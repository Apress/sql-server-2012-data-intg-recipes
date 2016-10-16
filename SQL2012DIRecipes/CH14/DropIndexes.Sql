-- Create table to hold script elements
IF OBJECT_ID('tempdb..#ScriptElements') IS NOT NULL
DROP TABLE tempdb..#ScriptElements;
CREATE TABLE #ScriptElements (ID INT IDENTITY(1,1), ScriptElement NVARCHAR(MAX))
-- Non-Clustered Indexes
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
'DROP INDEX '
+ INDEX_NAME
+ ' ON '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
FROM MetaData_Indexes
WHERE type_desc = 'NONCLUSTERED'
AND is_primary_key = 0
AND is_unique_constraint = 0
-- Unique constraints
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
'ALTER TABLE '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
+ ' DROP CONSTRAINT '
+ INDEX_NAME
FROM MetaData_Indexes
WHERE is_unique_constraint = 1
-- Clustered Indexes
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
'DROP INDEX '
+ INDEX_NAME
+ ' ON '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
FROM MetaData_Indexes
WHERE type_desc = 'CLUSTERED'
AND is_primary_key = 0
-- Primary Key Indexes
INSERT INTO #ScriptElements (ScriptElement)
SELECT DISTINCT
'ALTER TABLE '
+ DATABASE_NAME + '.' + SCHEMA_NAME + '.' + TABLE_NAME
+ ' DROP CONSTRAINT '
+ INDEX_NAME
FROM MetaData_Indexes
WHERE is_primary_key = 1
-- Create and execute DROP scripts
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
CLOSE DropIndex_CUR ;
DEALLOCATE DropIndex_CUR ;