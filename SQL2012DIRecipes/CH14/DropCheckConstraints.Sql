-- Create DROP statements
-- Drop table to hold script elements
IF OBJECT_ID('tempdb..#ScriptElements') IS NOT NULL
DROP TABLE tempdb..#ScriptElements;
CREATE TABLE #ScriptElements (ID INT IDENTITY(1,1), ScriptElement NVARCHAR(MAX))

INSERT INTO #ScriptElements
SELECT DISTINCT
'ALTER TABLE '
+ SCHEMA_NAME
+ '.'
+ TABLE_NAME
+ ' DROP CONSTRAINT '
+ CheckConstraintName
FROM MetaData_CheckConstraints ;
-- Execute DROP scripts
DECLARE @DropFK NVARCHAR(MAX)
DECLARE DropFK_CUR CURSOR
FOR
SELECT ScriptElement FROM #ScriptElements ORDER BY ID
OPEN DropFK_CUR
FETCH NEXT FROM DropFK_CUR INTO @DropFK
WHILE @@FETCH_STATUS <> -1
BEGIN
EXEC (@DropFK)
FETCH NEXT FROM DropFK_CUR INTO @DropFK
END ;
CLOSE DropFK_CUR;
DEALLOCATE DropFK_CUR;