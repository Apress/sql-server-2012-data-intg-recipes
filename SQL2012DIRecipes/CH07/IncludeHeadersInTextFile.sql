SELECT ID, ClientName, Country
FROM (
SELECT 'ID' AS ID, 'ClientName' AS ClientName, 'Country' AS Country, 0 AS RowOrder
UNION
SELECT CAST(ID AS VARCHAR(11)), ClientName, Country, 1 AS RowOrder
FROM CarSales.dbo.Client
) A
ORDER BY RowOrder,ID;


SELECT CAST(ID AS VARCHAR(11)) + '/' + ClientName + ';' + Country
FROM CarSales.dbo.Client;