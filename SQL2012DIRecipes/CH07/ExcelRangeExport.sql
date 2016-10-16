INSERT INTO OPENDATASOURCE('Microsoft.ACE.OLEDB.12.0',
'Data Source = C:\SQL2012DIRecipes\CH07\InsertFile.xls;
Extended Properties = Excel 12.0')...[Clients$]
SELECT ID, ClientName FROM dbo.Client

INSERT INTO OPENROWSET(
'Microsoft.ACE.OLEDB.12.0','Excel 12.0; Database = C:\SQL2012DIRecipes\CH07\InsertFile.xlsx;'
, 'SELECT ID, ClientName FROM DestinationRange')
SELECT ID, ClientName FROM dbo.Client