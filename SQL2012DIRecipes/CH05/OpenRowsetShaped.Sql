USE DATABASE CarSales;
GO
SELECT CAST(ID AS VARCHAR(5)) AS IdentityNumber, LEFT(Town, 25) AS Town
INTO MyTableForShapedBulkInserts
FROM OPENROWSET(
BULK 'C:\SQL2012DIRecipes\CH05\Clients.bcp'
,FORMATFILE='C:\SQL2012DIRecipes\CH05\Clients.fmt'
) as Cl
WHERE ClientSize = 'M'
ORDER BY County DESC;