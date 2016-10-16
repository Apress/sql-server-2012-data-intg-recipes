DROP TABLE CarSales_Staging.dbo.Invoice_XML_Multi;
DROP TABLE CarSales_Staging.dbo.Invoice_Lines_XML_Multi;
CREATE TABLE CarSales_Staging.dbo.Invoice_XML_Multi
(
ID INT NOT NULL PRIMARY KEY,
InvoiceNumber VARCHAR (50) NULL,
DeliveryCharge SMALLMONEY NULL
) ;
GO
CREATE TABLE CarSales_Staging.dbo.Invoice_Lines_XML_Multi
(
ID INT NOT NULL PRIMARY KEY,
InvoiceID INT NOT NULL FOREIGN KEY REFERENCES Invoice_XML_Multi (ID),
SalePrice MONEYNULL,
) ;
GO