CREATE PROCEDURE pr_AuditETL
AS
DECLARE @SQL AS VARCHAR(MAX)
DECLARE @TableToAudit AS VARCHAR(150)
DECLARE @SchemaToAudit AS VARCHAR(150)
DECLARE @DatabaseToAudit AS VARCHAR(150)
DECLARE Tables_CUR CURSOR
FOR
SELECT SchemaName, TableName, DatabaseName FROM dbo.RefTables
OPEN Tables_CUR
FETCH NEXT FROM Tables_CUR INTO @SchemaToAudit, @TableToAudit, @DatabaseToAudit
WHILE @@FETCH_STATUS =0
BEGIN
SET @SQL = 'INSERT INTO dbo.TableAuditData (LastUpdatedDate, LastRunID, QualifiedTableName, LastRecordCount) SELECT MAX(LastRunDate), MAX(RunID),''' +
@DatabaseToAudit + '.' + @SchemaToAudit + '.' + @TableToAudit + ''',COUNT(RunID)
FROM '+ @DatabaseToAudit + '.' + @SchemaToAudit + '.' + @TableToAudit
EXECUTE (@SQL)
FETCH NEXT FROM Tables_CUR INTO @SchemaToAudit, @TableToAudit, @DatabaseToAudit
END
CLOSE Tables_CUR
DEALLOCATE Tables_CUR