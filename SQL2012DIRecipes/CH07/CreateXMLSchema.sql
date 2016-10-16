SELECT
ID
,ClientName
,Address1
,Address2
,Town
,County
,PostCode
,Country
FROM CarSales.dbo.Client
WHERE 1 = 0
FOR XML AUTO, XMLSCHEMA;