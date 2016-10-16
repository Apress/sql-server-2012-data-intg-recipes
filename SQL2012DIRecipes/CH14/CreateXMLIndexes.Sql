DECLARE @SORT_IN_TEMPDB BIT = 1
DECLARE @DROP_EXISTING BIT = 0
-- Create table to hold script elements
IF OBJECT_ID('tempdb..#ScriptElements') IS NOT NULL
DROP TABLE tempdb..#ScriptElements;
CREATE TABLE #ScriptElements (ID INT IDENTITY(1,1), ScriptElement NVARCHAR(MAX))
-- Non-Clustered Indexes
IF OBJECT_ID('tempdb..#Tmp_IndexedFields') IS NOT NULL
DROP TABLE tempdb..#Tmp_IndexedFields;
INSERT INTO #ScriptElements
SELECT DISTINCT
'CREATE PRIMARY XML INDEX '
+ PrimaryIndexName
+ ' ON '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
+ ' (' + XMLColumnName + ') '
+ ' WITH ('
+ CASE
WHEN is_padded = 1 THEN ' PAD_INDEX = OFF, '
ELSE ' PAD_INDEX = ON, '
END

+ CASE
WHEN [allow_page_locks] = 1 THEN ' ALLOW_PAGE_LOCKS = ON, '
ELSE 'ALLOW_PAGE_LOCKS = OFF, '
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
ELSE ' DROP_EXISTING = OFF '
END
+ ')'
FROMMetadata_XMLIndexes
WHEREIsPrimaryXMLIndex = 1 ;
-- Secondary XML index
INSERT INTO #ScriptElements
SELECT
'CREATE XML INDEX '
+ INDEX_NAME
+ ' ON '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
+ ' (' + XMLColumnName + ') '
+ ' USING XML INDEX '
+ PrimaryIndexName
+ ' FOR ' + secondarytypedescription
+ ' WITH ('
+ CASE
WHEN is_padded = 1 THEN ' PAD_INDEX = OFF, '
ELSE ' PAD_INDEX = ON, '
END
+ CASE
WHEN [allow_page_locks] = 1 THEN ' ALLOW_PAGE_LOCKS = ON, '
ELSE 'ALLOW_PAGE_LOCKS = OFF, '
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
ELSE ' DROP_EXISTING = OFF '
END
+ ')'
FROM Metadata_XMLIndexes
WHERE IsPrimaryXMLIndex = 0
ORDER BY SERVER_NAME, DATABASE_NAME, SCHEMA_NAME, TABLE_NAME ;
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
CLOSE CreateIndex_CUR;
DEALLOCATE CreateIndex_CUR;