IF OBJECT_ID('dbo.Invoice_Lines_STG') IS NOT NULL DROP TABLE dbo.Invoice_Lines_STG;
GO
CREATE TABLE dbo.Invoice_Lines_STG
(
ID int NOT NULL,
InvoiceID INT NULL,
StockID INT NULL,
SalePrice NUMERIC(18, 2) NULL,
VersionStampVARBINARY(8) NULL
);
GO