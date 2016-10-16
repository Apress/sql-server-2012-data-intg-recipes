BULK INSERT CarSales_Staging.dbo.Invoice
FROM 'C:\SQL2012DIRecipes\CH02\Invoices.Txt'
WITH
(
FIRSTROW = 2,
FORMATFILE = 'C:\SQL2012DIRecipes\CH02\Invoicebulkload.Xml'
)