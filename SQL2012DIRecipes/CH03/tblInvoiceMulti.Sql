CREATE TABLE CarSales_Staging.dbo.Invoice_XML_Multi
(
ID INT NULL,
InvoiceNumber VARCHAR (50) NULL,
DeliveryCharge SMALLMONEY NULL
) ;
GO
CREATE TABLE CarSales_Staging. dbo.Invoice_Lines_XML_Multi
(
InvoiceID INT NULL,
SalePrice MONEYNULL,
) ;
GO