INSERT INTO OPENROWSET('Microsoft.ACE.OLEDB.12.0',C:\SQL2012DIRecipes\CH07\TestAccess.mdb';
'admin';'',ClientExport)
SELECT ID, ClientName FROM dbo.Client