UPDATE DST
SET DST.InvoiceID = UPD.InvoiceID
,DST.SalePrice = UPD.SalePrice
,DST.LineItem = UPD.LineItem
,DST.UpdateDate = SRC.UpdateDate
,DST.StockID = UPD.StockID
,DST.HashData = UPD.HashData
FROM dbo.Invoice_Lines DST
INNER JOIN ##Invoice_Lines_Updates UPD
ON DST.ID = UPD.ID