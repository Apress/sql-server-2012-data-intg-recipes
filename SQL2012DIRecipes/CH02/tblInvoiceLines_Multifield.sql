CREATE TABLE CarSales_Staging.dbo.InvoiceLines_Multifield
(
ID INT NULL,
InvoiceID VARCHAR(25) NULL,
StockID INT NULL,
Quantity INT NULL,
SalePrice MONEY NULL,
Comment1 VARCHAR(150) NULL,
Comment2 VARCHAR(500) NULL
) ;
GO