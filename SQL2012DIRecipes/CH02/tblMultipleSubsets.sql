CREATE TABLE InvoiceHeader
(
ID INT
,InvoiceNumber VARCHAR(50)
,ClientID INT
,InvoiceDate DATETIME
,TotalDiscount NUMERIC(18,2)
,DeliveryCharge
) ;
GO
CREATE TABLE InvoiceLine
(
ID INT
InvoiceID INT
StockID INT
SalePrice NUMERIC(18,2)
Timestamp BIGINT
DateUpdated DATETIME
LineItem INT
) ;
GO