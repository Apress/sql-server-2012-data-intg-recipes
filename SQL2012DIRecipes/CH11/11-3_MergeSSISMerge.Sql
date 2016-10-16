--Merge routine
-- The two data sets
MERGE dbo.Invoice_Lines AS DST
USING dbo.Invoice_Lines_STG AS SRC
ON DST.ID = SRC.ID
-- Deletes
WHEN NOT MATCHED BY SOURCE
THEN DELETE
-- Updates
WHEN MATCHED AND
(
ISNULL(SRC.VersionStamp,0) <> ISNULL(DST.VersionStamp,0)
)
THEN UPDATE
SET DST.InvoiceID = SRC.InvoiceID
,DST.StockID = SRC.StockID
,DST.SalePrice = SRC.SalePrice
,DST.VersionStamp = SRC.VersionStamp
-- Inserts
WHEN NOT MATCHED THEN
INSERT
(
ID
,InvoiceID
,StockID
,SalePrice
,VersionStamp
)

VALUES
(
ID
,InvoiceID
,StockID
,SalePrice
,VersionStamp
)
;
