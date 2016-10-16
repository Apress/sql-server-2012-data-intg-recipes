DECLARE @SORT_IN_TEMPDB BIT = 1
DECLARE @DROP_EXISTING BIT = 0

DECLARE @ONLINE BIT = 0
DECLARE @MAX_DEGREE_OF_PARALLELISM TINYINT = 0
-- Create table to hold script elements
IF OBJECT_ID('tempdb..#ScriptElements') IS NOT NULL
DROP TABLE tempdb..#ScriptElements;
CREATE TABLE #ScriptElements (ID INT IDENTITY(1,1), ScriptElement NVARCHAR(MAX))
-- Non-Clustered Indexes
IF OBJECT_ID('tempdb..#Tmp_IndexedFields') IS NOT NULL
DROP TABLE tempdb..#Tmp_IndexedFields;
-- IndexedFields
;
WITH Core_CTE ( INDEX_NAME, Rank, Name )
AS
(
SELECT INDEX_NAME,ROW_NUMBER()
OVER( PARTITION BY INDEX_NAME ORDER BY INDEX_NAME, key_ordinal)
,CAST(name AS VARCHAR(MAX))
FROM MetaData_Indexes
WHERE is_included_column = 0),
Root_CTE ( INDEX_NAME, Rank, Name )
AS ( SELECT INDEX_NAME, Rank, name
FROM Core_CTE
WHERE Rank = 1 ),
Recursion_CTE ( INDEX_NAME, Rank, Name )
AS ( SELECT INDEX_NAME, Rank, name
FROM Root_CTE
UNION ALL
SELECT Core_CTE.INDEX_NAME, Core_CTE.Rank,
Recursion_CTE.name + ', ' + Core_CTE.name
FROM Core_CTE
INNER JOIN Recursion_CTE
ON Core_CTE.INDEX_NAME = Recursion_CTE.INDEX_NAME
AND Core_CTE.Rank = Recursion_CTE.Rank + 1 )
SELECTINDEX_NAME, MAX( Name ) AS IndexFields_Main
INTO #Tmp_IndexedFields
FROMRecursion_CTE
GROUP BYINDEX_NAME;
-- Included fields

IF OBJECT_ID('tempdb..#Tmp_IncludedFields') IS NOT NULL
DROP TABLE tempdb..#Tmp_IncludedFields;
WITH Core_CTE ( INDEX_NAME, Rank, Name )
AS ( SELECT INDEX_NAME,
ROW_NUMBER() OVER( PARTITION BY INDEX_NAME ORDER BY INDEX_NAME ),
CAST( name AS VARCHAR(MAX) )
FROM MetaData_Indexes WHERE is_included_column = 1 ),
Root_CTE ( INDEX_NAME, Rank, Name )
AS ( SELECT INDEX_NAME, Rank, name
FROM Core_CTE
WHERE Rank = 1 ),
Recursion_CTE ( INDEX_NAME, Rank, Name )
AS ( SELECT INDEX_NAME, Rank, name
FROM Root_CTE
UNION ALL
SELECT Core_CTE.INDEX_NAME, Core_CTE.Rank,
Recursion_CTE.name + ', ' + Core_CTE.name
FROM Core_CTE
INNER JOIN Recursion_CTE
ON Core_CTE.INDEX_NAME = Recursion_CTE.INDEX_NAME
AND Core_CTE.Rank = Recursion_CTE.Rank + 1 )
SELECT INDEX_NAME, MAX( Name ) AS IndexFields_Included
INTO #Tmp_IncludedFields
FROM Recursion_CTE
GROUP BY INDEX_NAME;
-- Create Index Script
-- First, metadata for core indexes
IF OBJECT_ID('tempdb..#Tmp_IndexData') IS NOT NULL
DROP TABLE tempdb..#Tmp_IndexData;
SELECT DISTINCT
MetaData_Indexes.SCHEMA_NAME
,MetaData_Indexes.TABLE_NAME
,MetaData_Indexes.INDEX_NAME
,#Tmp_IndexedFields.IndexFields_Main
,#Tmp_IncludedFields.IndexFields_Included
,MetaData_Indexes.type_desc
,MetaData_Indexes.is_unique
,MetaData_Indexes.has_filter

,MetaData_Indexes.filter_definition
,MetaData_Indexes.is_padded
,MetaData_Indexes.IsNoRecompute
,MetaData_Indexes.[ignore_dup_key]
,MetaData_Indexes.[allow_page_locks]
,MetaData_Indexes.[allow_row_locks]
,MetaData_Indexes.fill_factor
,MetaData_Indexes.DataSpace
,MetaData_Indexes.is_primary_key
,MetaData_Indexes.is_unique_constraint
INTO #Tmp_IndexData
FROM MetaData_Indexes
INNER JOIN #Tmp_IndexedFields
ON MetaData_Indexes.INDEX_NAME = #Tmp_IndexedFields.INDEX_NAME
LEFT OUTER JOIN #Tmp_IncludedFields
ON MetaData_Indexes.INDEX_NAME = #Tmp_IncludedFields.INDEX_NAME
-- Create primary keys
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
' ALTER TABLE '
+ SCHEMA_NAME + '.' + TABLE_NAME
+ ' ADD CONSTRAINT '
+ INDEX_NAME
+ ' PRIMARY KEY '
+ CASE
WHEN type_desc = 'CLUSTERED' THEN 'CLUSTERED '
ELSE
'NONCLUSTERED '
END
+ ' (' + IndexFields_Main + ')'
+ ' ON [' + DataSpace + ']'
FROM #Tmp_IndexData
WHERE #Tmp_IndexData.is_primary_key = 1
-- Create clustered indexes
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
'CREATE '
+ CASE
WHEN is_unique = 1 THEN 'UNIQUE '
ELSE ''
END

+ 'CLUSTERED INDEX '
+ INDEX_NAME + ' ON ' + SCHEMA_NAME + '.' + TABLE_NAME + ' (' + IndexFields_Main + ')'
+ ' WITH ('
+ CASE
WHEN is_padded = 1 THEN ' PAD_INDEX = OFF, '
ELSE ' PAD_INDEX = ON, '
END
+ CASE
WHEN IsNoRecompute = 1 THEN ' STATISTICS_NORECOMPUTE = OFF, '
ELSE 'STATISTICS_NORECOMPUTE = ON, '
END
+ CASE
WHEN [ignore_dup_key] = 1 THEN ' IGNORE_DUP_KEY = ON, '
ELSE ' IGNORE_DUP_KEY = OFF, '
END
+ CASE
WHEN [allow_page_locks] = 1 THEN ' ALLOW_PAGE_LOCKS = ON, '
ELSE 'ALLOW_PAGE_LOCKS = OFF, '
END
+ CASE
WHEN fill_factor IS NOT NULL THEN ' FILLFACTOR = ' + CAST(fill_factor AS VARCHAR(5)) + ','
ELSE ''
END
+ CASE
WHEN [allow_row_locks] = 1 THEN ' ALLOW_ROW_LOCKS = ON, '
ELSE ' ALLOW_ROW_LOCKS = OFF, '
END
+ CASE
WHEN @SORT_IN_TEMPDB = 1 THEN ' SORT_IN_TEMPDB = ON, '
ELSE ' SORT_IN_TEMPDB = OFF, '
END
+ CASE
WHEN @DROP_EXISTING = 1 THEN ' DROP_EXISTING = ON, '
ELSE ' DROP_EXISTING = OFF, '
END
+ CASE
WHEN @ONLINE = 1 THEN ' ONLINE = ON '
ELSE ' ONLINE = OFF '
END
+ CASE
WHEN @MAX_DEGREE_OF_PARALLELISM = 0 THEN ''
ELSE ' MAXDOP = ' + CAST(@MAX_DEGREE_OF_PARALLELISM AS NVARCHAR(2))
END
+ ')'
+ ' ON [' + DataSpace + ']'
FROM #Tmp_IndexData
WHERE #Tmp_IndexData.is_primary_key = 0
AND #Tmp_IndexData.is_unique_constraint = 0
AND type_desc = 'CLUSTERED'
-- Create Unique Indexes
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
' ALTER TABLE '
+ SCHEMA_NAME + '.' + TABLE_NAME
+ ' ADD CONSTRAINT '
+ INDEX_NAME
+ ' UNIQUE '
+ CASE
WHEN type_desc = 'CLUSTERED' THEN 'CLUSTERED '
ELSE
'NONCLUSTERED '
END
+ ' (' + IndexFields_Main + ')'
+ ' ON [' + DataSpace + ']'
FROM #Tmp_IndexData
WHERE #Tmp_IndexData.is_unique_constraint = 1 ;
-- Create non-clustered indexes
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
'CREATE '
+ CASE
WHEN is_unique = 1 THEN 'UNIQUE '
ELSE ''
END
+ 'NONCLUSTERED INDEX '
+ INDEX_NAME + ' ON ' + SCHEMA_NAME + '.' + TABLE_NAME + ' (' + IndexFields_Main + ')'
+ CASE
WHEN IndexFields_Included IS NOT NULL THEN ' INCLUDE ' + ' (' + IndexFields_Included + ')'
ELSE ''
END
+ CASE
WHEN has_filter = 1 THEN ' WHERE ' + filter_definition
ELSE ''
END
+ ' WITH ('
+ CASE
WHEN is_padded = 1 THEN ' PAD_INDEX = OFF, '
ELSE ' PAD_INDEX = ON, '
END
+ CASE
WHEN IsNoRecompute = 1 THEN ' STATISTICS_NORECOMPUTE = OFF, ' -- CHECK LOGIC
ELSE 'STATISTICS_NORECOMPUTE = ON, '
END
+ CASE
WHEN [ignore_dup_key] = 1 THEN ' IGNORE_DUP_KEY = ON, '
ELSE ' IGNORE_DUP_KEY = OFF, '
END
+ CASE
WHEN [allow_page_locks] = 1 THEN ' ALLOW_PAGE_LOCKS = ON, '
ELSE 'ALLOW_PAGE_LOCKS = OFF, '
END
+ CASE
WHEN fill_factor IS NOT NULL THEN ' FILLFACTOR = ' + CAST(fill_factor AS VARCHAR(5)) + ','
ELSE ''
END
+ CASE
WHEN [allow_row_locks] = 1 THEN ' ALLOW_ROW_LOCKS = ON, '
ELSE ' ALLOW_ROW_LOCKS = OFF, '
END
+ CASE
WHEN @SORT_IN_TEMPDB = 1 THEN ' SORT_IN_TEMPDB = ON, '
ELSE ' SORT_IN_TEMPDB = OFF, '
END
+ CASE
WHEN @DROP_EXISTING = 1 THEN ' DROP_EXISTING = ON, '
ELSE ' DROP_EXISTING = OFF, '
END
+ CASE
WHEN @ONLINE = 1 THEN ' ONLINE = ON '
ELSE ' ONLINE = OFF '
END
+ CASE
WHEN @MAX_DEGREE_OF_PARALLELISM = 0 THEN ''
ELSE ' MAXDOP = ' + CAST(@MAX_DEGREE_OF_PARALLELISM AS NVARCHAR(2))
END
+ ')'
+ ' ON [' + DataSpace + ']'
FROM #Tmp_IndexData
WHERE #Tmp_IndexData.is_primary_key = 0
AND #Tmp_IndexData.is_unique_constraint = 0
AND type_desc = 'NONCLUSTERED'
;
-- Create and execute CREATE scripts
DECLARE @CreateIndex NVARCHAR(MAX)
DECLARE CreateIndex_CUR CURSOR
FOR
SELECT ScriptElement FROM #ScriptElements ORDER BY ID
OPEN CreateIndex_CUR
FETCH NEXT FROM CreateIndex_CUR INTO @CreateIndex
WHILE @@FETCH_STATUS <> -1
BEGIN
EXEC (@CreateIndex)
FETCH NEXT FROM CreateIndex_CUR INTO @CreateIndex
END ;
CLOSE CreateIndex_CUR ;
DEALLOCATE CreateIndex_CUR ;