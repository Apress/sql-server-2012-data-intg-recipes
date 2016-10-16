BULK INSERT CarSales_Staging.dbo.InvoiceBulkLoad
FROM 'C:\SQL2012DIRecipes\CH02\InvoiceBulkLoad.Txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);

BULK INSERT CarSales_Staging.dbo.InvoiceBulkLoad
FROM 'C:\SQL2012DIRecipes\CH02\InvoiceBulkLoad.Txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n',
FIRSTROW = 2
);