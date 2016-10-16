EXECUTE sp_addlinkedserver
EXCEL_SQL, -- The Linked Sever name
'Jet 4.0', -- The (purely decorative) product name
'Microsoft.Jet.OLEDB.4.0', -- The installed driver
'C:\SQL2012DIRecipes\CH07\InsertFile.xls', -- The destination file and path
NULL, -- The location – not used
'Excel 8.0'; – The provider string, specifying the Excel version
GO

EXECUTE sp_addlinkedsrvlogin
EXCEL_SQL, -- The name of the linked Server
false, -- UseSelf – overrides the default
NULL, -- Local user
NULL, -- Remote user
NULL; – Remote login
GO

INSERT INTO EXCEL_SQL...[Clients$]
SELECT ID, ClientName from dbo.Client;