EXECUTE Master.dbo.sp_addlinkedserver
srv_Text -- The Linked Server name
,'ACE' -- The product name
,'Microsoft.ACE.OLEDB.12.0' -- The provider name
,'C:\SQL2012DIRecipes\CH02' -- The data source
,NULL -- The location
,'Text'; -- The provider string
GO


INSERT INTO srv_Text...InsertFile#txt (IDNo,ClientNameHere)
SELECT ID,ClientName FROM dbo.Client;