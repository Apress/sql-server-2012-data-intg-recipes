-- Drop table to hold script elements
IF OBJECT_ID('tempdb..#ScriptElements') IS NOT NULL
DROP TABLE tempdb..#ScriptElements;
CREATE TABLE #ScriptElements (ID INT IDENTITY(1,1), ScriptElement NVARCHAR(MAX));
INSERT INTO #ScriptElements
SELECT DISTINCT
'ALTER TABLE '
+ SCHEMA_NAME
+ '.'
+ TABLE_NAME
+ ' ADD CONSTRAINT '
+ FOREIGN_KEY_NAME
+ ' FOREIGN KEY ('
+ ColumnList
+ ') REFERENCES '
+ REFERENCED_TABLE_SCHEMA_NAME
+ '.'
+ REFERENCED_TABLE_NAME
+ ' ('
+ ColumnList
+ ')'
FROM Tmp_Metadata_ForeignKeys;
-- Execute CREATE scripts
DECLARE @CreateFK NVARCHAR(MAX)
DECLARE DropIndex_CUR CURSOR
FOR
SELECT ScriptElement FROM #ScriptElements ORDER BY ID
OPEN DropIndex_CUR
FETCH NEXT FROM DropIndex_CUR INTO @CreateFK
WHILE @@FETCH_STATUS <> -1
BEGIN
EXEC (@CreateFK)
FETCH NEXT FROM DropIndex_CUR INTO @CreateFK
END;
CLOSE DropIndex_CUR;
DEALLOCATE DropIndex_CUR;