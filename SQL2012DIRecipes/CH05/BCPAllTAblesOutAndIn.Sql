DECLARE @InOut BIT = 0;
DECLARE @BCPDatabaseName VARCHAR(128) = 'CarSales';
DECLARE @BCPDirectoryName VARCHAR(128) = 'C:\SQL2012DIRecipes\CH05\';
DECLARE @BCPParameters VARCHAR(100) = '-T';
DECLARE @BCPOutServer VARCHAR(50) = 'ADAM02';
DECLARE @SQLTextBI NVARCHAR(4000) = '';
DECLARE @SQLTextBCP NVARCHAR(4000) = '';
DECLARE @SQLParametersBulkInsert NVARCHAR(4000) =
N'@BCPDatabaseNameIN VARCHAR(128)
,@BCPDirectoryNameIN VARCHAR(128)';
DECLARE @SQLParametersBCPOUT NVARCHAR(4000) =
N'@BCPDatabaseNameIN VARCHAR(128)
,@BCPDirectoryNameIN VARCHAR(128)
,@BCPOutServerIN VARCHAR(128)
,@BCPParametersIN VARCHAR(128)';
DECLARE @BCPSchemaName VARCHAR(128);
DECLARE @BCPTableName VARCHAR(128);
IF @InOut = 1
BEGIN
SET @SQLTextBCP = 'SELECT ''BCP '' + @BCPDatabaseNameIN + ''.'' + TABLE_SCHEMA + ''.''
+ TABLE_NAME + '' OUT '' + @BCPDirectoryNameIN + TABLE_SCHEMA + ''_'' + TABLE_NAME
+ ''.bcp'' + '' -N '' + ''-S'' + @BCPOutServerIN + '' '' + @BCPParametersIN '
SET @SQLTextBCP = @SQLTextBCP + ' FROM ' + @BCPDatabaseName + '.INFORMATION_SCHEMA.TABLES'
SET @SQLTextBCP = @SQLTextBCP + ' WHERE TABLE_TYPE = ''BASE TABLE''';
EXECUTE master.dbo.sp_executesql @SQLTextBCP
,@SQLParametersBCPOUT
,@BCPDatabaseNameIN = @BCPDatabaseName
,@BCPDirectoryNameIN = @BCPDirectoryName
,@BCPOutServerIN = @BCPOutServer
,@BCPParametersIN = @BCPParameters;
END
ELSE
BEGIN
SET @SQLTextBI = 'SELECT ''BULK INSERT '' + @BCPDatabaseNameIN + ''.'' + TABLE_SCHEMA
+ ''.'' + TABLE_NAME + '' FROM '''''' + @BCPDirectoryNameIN + TABLE_SCHEMA + ''_''
+ TABLE_NAME + ''.bcp'''' WITH (DATAFILETYPE=''''widenative'''')'''
SET @SQLTextBI = @SQLTextBI + ' FROM ' + @BCPDatabaseName + '.INFORMATION_SCHEMA.TABLES'
SET @SQLTextBI = @SQLTextBI + ' WHERE TABLE_TYPE = ''BASE TABLE''';
EXECUTE master.dbo.sp_executesql @SQLTextBI
,@SQLParametersBulkInsert
,@BCPDatabaseNameIN = @BCPDatabaseName
,@BCPDirectoryNameIN = @BCPDirectoryName;
END