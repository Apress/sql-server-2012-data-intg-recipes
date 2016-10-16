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
+ CheckConstraintName
+ ' CHECK '
+ [definition]
FROM MetaData_CheckConstraints ;
-- Execute CREATE scripts
DECLARE @CreateFK NVARCHAR(MAX)
DECLARE CreateFK_CUR CURSOR
FOR
SELECT ScriptElement FROM #ScriptElements ORDER BY ID
OPEN CreateFK_CUR
FETCH NEXT FROM CreateFK_CUR INTO @CreateFK
WHILE @@FETCH_STATUS <> -1
BEGIN
EXEC (@CreateFK)
FETCH NEXT FROM CreateFK_CUR INTO @CreateFK
END ;
CLOSE CreateFK_CUR;
DEALLOCATE CreateFK_CUR;