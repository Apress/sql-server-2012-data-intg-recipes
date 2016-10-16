INSERT INTO OPENROWSET('Microsoft.Jet.OLEDB.4.0','Text;Database = C:\SQL2012DIRecipes\CH07\;', 'SELECT ID, ClientName FROM InsertFile.txt')
SELECT ID, ClientName FROM dbo.Client;

