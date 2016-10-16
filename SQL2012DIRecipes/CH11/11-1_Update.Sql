UPDATE DST
SET
DST.InvoiceID = UPD.InvoiceID
,DST.SalePrice = UPD.SalePrice
,DST.StockID = UPD.StockID
,DST.VersionStamp = UPD.VersionStamp
FROM dbo.Invoice_Lines DST
INNER JOIN dbo.Invoice_Lines_Updates UPD
ON DST.ID = UPD.ID