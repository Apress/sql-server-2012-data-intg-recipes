EXECUTE master.dbo.sp_configure 'Ole Automation Procedures', 1;
GO
reconfigure;
GO

DECLARE @handle INT;
DECLARE @VBSobject INT;
EXECUTE @handle = sp_OACreate 'SQLXMLBulkLoad.SQLXMLBulkLoad.4.0', @VBSobject OUT;
EXECUTE @handle = sp_OASetProperty @VBSobject, 'ConnectionString', 'provider=SQLOLEDB;data
SQL Server Data Type
XSD Data Type
sql_variant
string
sysname
string
text
string
timestamp
dateTime
tinyint
unsignedByte
varbinary
base64Binary
varchar
string
uniqueidentifier
string
Table 3-3. (continued)
source=ADAM02;database=CarSales_Staging;Uid=Adam;Pwd = Me4B0ss;
EXECUTE @handle = sp_OASetProperty @VBSobject, 'ErrorLogFile','C:\SQL2012DIRecipes\CH03\SQLXMLBulkLoadImporterror.log';
EXECUTE @handle = sp_OAMethod @VBSobject, 'Execute', NULL, 'C:\SQL2012DIRecipes\CH03\SQLXMLBulkLoadImport_Simple.xsd', 'C:\SQL2012DIRecipes\CH03\Clients_Simple.xml';
EXECUTE @handle = sp_OADestroy @VBSobject;
