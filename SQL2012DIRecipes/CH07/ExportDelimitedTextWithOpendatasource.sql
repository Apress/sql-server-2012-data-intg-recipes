INSERT INTO
OPENDATASOURCE('Microsoft.Jet.OLEDB.4.0',
'Data Source = C:\SQL2012DIRecipes\CH07\;Text; FMT = Delimited')...[InsertFile#Txt]
SELECT ID, ClientName FROM dbo.Client;