SELECT ID AS InventoryNumber, LEFT(Marque,20) AS VehicleType
INTO RollsRoyce
FROM OPENDATASOURCE(
'Microsoft.ACE.OLEDB.12.0',
'Data Source = C:\SQL2012DIRecipes\CH01\CarSales.xls;Extended Properties = Excel 8.0')...Stock$
WHERE MAKE LIKE '%royce%'
ORDER BY Marque;