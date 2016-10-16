INSERT INTO Tmp_Metadata_ForeignKeys
SELECT
SCH.name AS SCHEMA_NAME
,OBJ.name AS TABLE_NAME
,FRK.name AS FOREIGN_KEY_NAME
,COL.name AS COLUMN_NAME
,RefSCH.name AS REFERENCED_TABLE_SCHEMA_NAME
,RefTBL.name AS REFERENCED_TABLE_NAME
,RefCOL.name AS REFERENCED_COLUMN_NAME
,CAST(NULL AS NVARCHAR(300)) AS ColumnList
FROM sys.foreign_keys FRK
INNER JOIN sys.objects OBJ
ON FRK.parent_object_id = OBJ.object_id
AND FRK.schema_id = OBJ.schema_id
INNER JOIN sys.schemas SCH
ON OBJ.schema_id = SCH.schema_id
INNER JOIN sys.foreign_key_columns FKC
ON FRK.object_id = FKC.constraint_object_id
AND FRK.parent_object_id = FKC.parent_object_id
INNER JOIN sys.columns COL
ON FKC.constraint_column_id = COL.column_id
AND FKC.parent_object_id = COL.object_id
INNER JOIN sys.columns AS RefCOL
ON FKC.referenced_object_id = RefCOL.object_id
AND FKC.referenced_column_id = RefCOL.column_id
INNER JOIN sys.objects AS RefTBL
ON FKC.referenced_object_id = RefTBL.object_id
INNER JOIN sys.schemas AS RefSCH
ON RefTBL.schema_id = RefSCH.schema_id
WHERE FRK.is_ms_shipped = 0
AND FRK.is_not_trusted = 0 ;
-- Define (concatenate) list of key columns
IF OBJECT_ID('TempDB..#Tmp_IndexedFields') IS NOT NULL
DROP TABLE TempDB..#Tmp_IndexedFields
;
WITH Core_CTE ( FOREIGN_KEY_NAME, Rank, COLUMN_NAME )
AS ( SELECT FOREIGN_KEY_NAME,
ROW_NUMBER() OVER( PARTITION BY FOREIGN_KEY_NAME ORDER BY
FOREIGN_KEY_NAME),
CAST( COLUMN_NAME AS VARCHAR(MAX) )
FROM Tmp_Metadata_ForeignKeys),
Root_CTE ( FOREIGN_KEY_NAME, Rank, COLUMN_NAME )
AS ( SELECT FOREIGN_KEY_NAME, Rank, COLUMN_NAME
FROM Core_CTE
WHERE Rank = 1 ),
Recursion_CTE ( FOREIGN_KEY_NAME, Rank, COLUMN_NAME )
AS
( SELECT FOREIGN_KEY_NAME, Rank, COLUMN_NAME
FROM Root_CTE
UNION ALL
SELECT Core_CTE.FOREIGN_KEY_NAME, Core_CTE.Rank,
Recursion_CTE.COLUMN_NAME + ', ' + Core_CTE.COLUMN_NAME
FROM Core_CTE
INNER JOIN Recursion_CTE
ON Core_CTE.FOREIGN_KEY_NAME = Recursion_CTE.FOREIGN_KEY_NAME
AND Core_CTE.Rank = Recursion_CTE.Rank + 1
)
SELECT FOREIGN_KEY_NAME, MAX( COLUMN_NAME ) AS ColumnList
INTO #Tmp_IndexedFields
FROM Recursion_CTE
GROUP BY FOREIGN_KEY_NAME;
UPDATET
SET T.ColumnList = Tmp.ColumnList
FROM Tmp_Metadata_ForeignKeys T
INNER JOIN #Tmp_IndexedFields Tmp
ON T.FOREIGN_KEY_NAME = Tmp.FOREIGN_KEY_NAME;