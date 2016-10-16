INSERT INTO CarSales_Staging.dbo.LuxuryCars (InventoryNumber, VehicleType)
SELECT CAST(ID AS INT) AS InventoryNumber, LEFT(Marque, 50) AS VehicleType
FROM OPENDATASOURCE(
'Microsoft.ACE.OLEDB.12.0',
'Data Source = C:\SQL2012DIRecipes\CH01\CarSales.xls;Extended Properties = Excel 8.0')...Stock$
WHERE MAKE LIKE '%royce%'
ORDER BY Marque;