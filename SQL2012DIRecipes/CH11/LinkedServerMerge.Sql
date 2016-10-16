--Merge routine
-- The two data sets
MERGE CarSales_Staging.dbo.Invoice_Lines AS DST
USING ADAMREMOTE.CarSales.dbo.Invoice_Lines AS SRC
ON DST.ID = SRC.ID
-- Deletes
WHEN NOT MATCHED BY SOURCE
THEN DELETE
-- Updates
WHEN MATCHED AND

(
ISNULL(SRC.InvoiceID,0) <> ISNULL(DST.InvoiceID,0)
OR ISNULL(SRC.StockID,0) <> ISNULL(DST.StockID,0)
OR ISNULL(SRC.SalePrice,0) <> ISNULL(DST.SalePrice,0)
)
THEN UPDATE
SET DST.InvoiceID = SRC.InvoiceID
,DST.StockID = SRC.StockID
,DST.SalePrice = SRC.SalePrice
-- Inserts
WHEN NOT MATCHED THEN
INSERT
(
ID
,InvoiceID
,StockID
,SalePrice
)
VALUES
(
ID
,InvoiceID
,StockID
,SalePrice
)
;