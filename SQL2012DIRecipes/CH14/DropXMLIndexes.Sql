-- Drop table to hold script elements
IF OBJECT_ID('tempdb..#ScriptElements') IS NOT NULL
DROP TABLE tempdb..#ScriptElements;
CREATE TABLE #ScriptElements (ID INT IDENTITY(1,1), ScriptElement NVARCHAR(MAX))
-- Non-Clustered Indexes
IF OBJECT_ID('tempdb..#Tmp_IndexedFields') IS NOT NULL
DROP TABLE tempdb..#Tmp_IndexedFields;
-- Secondary XML index
INSERT INTO #ScriptElements
SELECT DISTINCT
'DROP INDEX '
+ INDEX_NAME
+ ' ON '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
FROM Metadata_XMLIndexes
WHERE IsPrimaryXMLIndex = 0 ;
-- Primary XML index
INSERT INTO #ScriptElements
SELECT DISTINCT
'DROP INDEX '
+ PrimaryIndexName
+ ' ON '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
FROM Metadata_XMLIndexes
WHERE IsPrimaryXMLIndex = 1 ;
-- Drop and execute DROP scripts
DECLARE @DropIndex NVARCHAR(MAX)
DECLARE DropIndex_CUR CURSOR
FOR
SELECT ScriptElement FROM #ScriptElements ORDER BY ID

OPEN DropIndex_CUR
FETCH NEXT FROM DropIndex_CUR INTO @DropIndex
WHILE @@FETCH_STATUS <> -1
BEGIN
EXEC (@DropIndex)
FETCH NEXT FROM DropIndex_CUR INTO @DropIndex
END ;
CLOSE DropIndex_CUR;
DEALLOCATE DropIndex_CUR;