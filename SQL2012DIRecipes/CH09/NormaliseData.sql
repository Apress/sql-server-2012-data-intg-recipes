-- Add Clients
INSERT INTO dbo.Client (ClientName, Country, Town)
SELECT DISTINCT ClientName, Country, Town
FROM CarSales_Staging.dbo.DenormalisedSales DNS
WHERE NOT EXISTS (
SELECT ID
FROM dbo.Client
WHERE ClientName = DNS.ClientName
AND Country = DNS.Country AND Town = DNS.Town
);
-- Add Order Header
INSERT INTO dbo.Invoice (InvoiceNumber, TotalDiscount, DeliveryCharge, ClientID)
SELECT DISTINCT DS.InvoiceNumber, DS.TotalDiscount, DS.DeliveryCharge, CL.ID
FROM dbo.DenormalisedSales DS
INNER JOIN dbo.Client CL
ON CL.ClientName = DS.ClientName
AND CL.Country = DS.Country
AND CL.Town = DS.Town;
-- Add order detail
INSERT INTO dbo.Invoice_Lines (SalePrice, StockID, InvoiceID)
SELECT DISTINCT DS.SalePrice, DS.StockID, IV.ID
FROM CarSales_Staging.dbo.DenormalisedSales DS
INNER JOIN dbo.Invoice IV
ON IV.InvoiceNumber = DS.InvoiceNumber;