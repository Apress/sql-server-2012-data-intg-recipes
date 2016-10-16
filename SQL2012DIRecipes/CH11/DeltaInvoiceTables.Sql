CREATE TABLE dbo.Invoice_Lines
(
ID INT NOT NULL,
InvoiceID INT NULL,
StockID INT NULL,
SalePrice NUMERIC(18, 2) NULL,
VersionStamp VARBINARY(8) NULL -- this field is to hold ROWVERSION data
); -- The destination table with no IDENTITY column or referential integrity
GO
CREATE TABLE dbo.Invoice_Lines_Updates
(
ID INT NOT NULL,
InvoiceID INT NULL,
StockID INT NULL,
SalePrice NUMERIC(18, 2) NULL,
VersionStamp VARBINARY(8) NULL -- this field is to hold ROWVERSION data
) ; --The "scratch" table for updated records
GO
CREATE TABLE dbo.Invoice_Lines_Deletes
(
ID INT NULL
) ; -- The "scratch" table for you to deduce deleted records
GO