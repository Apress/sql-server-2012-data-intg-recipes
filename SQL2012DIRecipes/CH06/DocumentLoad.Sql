DECLARE @DocName NVARCHAR(255)
DECLARE @DocFullName NVARCHAR(255)
DECLARE @DocPath NVARCHAR(255)
DECLARE @DocType CHAR(10)
DECLARE @SQL NVARCHAR(4000)
DECLARE @SQLPARAMETERS NVARCHAR(4000)
DECLARE DOCLOAD_CUR CURSOR
FOR
SELECT ExternalFileName, ExternalFileDirectory, FileType
FROM CarSales_Staging.dbo.DocumentList
OPEN DOCLOAD_CUR
FETCH NEXT FROM DOCLOAD_CUR INTO @DocName, @DocPath, @DocType
WHILE @@FETCH_STATUS = 0
BEGIN
SET @DocFullName = @DocPath + '\' + @DocName
SET @SQL =
'
INSERT INTO dbo.DocuBlobs
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
FETCH NEXT FROM DOCLOAD_CUR INTO @DocName, @DocPath, @DocType
END
CLOSE DOCLOAD_CUR
DEALLOCATE DOCLOAD_CUR