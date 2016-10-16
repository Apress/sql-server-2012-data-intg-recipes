DELETE DST
FROM dbo.Invoice_Lines DST
INNER JOIN dbo.Invoice_Lines_Deletes DL
ON DST.ID = DL.ID


UPDATE DST
SET DST.InvoiceID = UPD.InvoiceID
,DST.StockID = UPD.StockID
,DST.SalePrice = UPD.SalePrice
FROM dbo.Invoice_Lines DST
INNER JOIN dbo.Invoice_Lines_Updates UPD
ON DST.ID = UPD.ID


DELETE FROM dbo.DeltaTracking
WHERE ObjectID = OBJECT_ID('dbo.Invoice_Lines')