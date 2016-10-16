SELECT ID, Marque
INTO MyAccessTempTable
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
'C:\SQL2012DIRecipes\CH01\CarSales.accdb';'admin';'', stock);