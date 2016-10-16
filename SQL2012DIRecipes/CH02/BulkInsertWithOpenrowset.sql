INSERT INTO CarSales_Staging.dbo.Invoices
SELECT ID, InvoiceNumber, ClientID
FROM OPENROWSET(BULK 'C:\SQL2012DIRecipes\CH02\Invoices.Txt', FORMATFILE = 'C:\SQL2012DIRecipes\CH02\Invoicebulkload.Xml') AS MyDATA;