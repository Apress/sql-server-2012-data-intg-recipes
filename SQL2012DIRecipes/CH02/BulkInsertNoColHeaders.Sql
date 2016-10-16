BULK INSERT dbo.Invoice
FROM 'C:\SQL2012DIRecipes\CH02\Invoices2.Txt'
WITH (FORMATFILE = 'C:\SQL2012DIRecipes\CH02\Invoices2.Xml');