INSERT INTO OPENROWSET('Microsoft.ACE.OLEDB.12.0','Excel 12.0;
Database = C:\SQL2012DIRecipes\CH07\InsertFile.xlsx;', 'SELECT ID, ClientName FROM [Clients$]')
SELECT ID, ClientName FROM dbo.Client;