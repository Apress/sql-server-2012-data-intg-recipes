CREATE PROCEDURE CarSales_Staging.dbo.pr_LoadBLOBsFromSSIS
(
@DocName NVARCHAR(255),
@DocPath NVARCHAR(255),
@DocFullName NVARCHAR(255),
@DocType CHAR(3)
)
AS
DECLARE @SQL NVARCHAR(4000)
DECLARE @SQLPARAMETERS VARCHAR(8000)
SET @SQL =
'
INSERT INTO dbo.DocumentList
(
ExternalFileName,
ExternalFileDirectory,
FileData,
FileType
)
SELECT '
+ '''' + @DocName + ''','
+ '''' + @DocPath + ''','
+ '(SELECT * FROM OPENROWSET(BULK ''' + @DocFullName + ''', SINGLE_BLOB) AS MyDoc ),'
+ '''' + @DocType + ''''


EXEC (@SQL)