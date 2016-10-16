CREATE VIEW dbo.vw_Invoice2
AS
SELECT ID, InvoiceNumber, ClientID
FROM dbo.Invoice;
GO

BULK INSERT dbo.vw_Invoice2
FROM 'C:\SQL2012DIRecipes\CH02\Invoices2.Txt'
WITH
(
FIELDTERMINATOR = ',',
ROWTERMINATOR = '\n'
);