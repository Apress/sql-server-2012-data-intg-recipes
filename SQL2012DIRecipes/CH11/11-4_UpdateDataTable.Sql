SELECT SRC.ID, SRC.InvoiceID,
SRC.StockID, SRC.SalePrice,
SRC.LineItem, SRC.DateUpdated
SRC.HashData
FROM dbo.Invoice_Lines SRC
INNER JOIN TMP_Updates TMP
ON SRC.ID = TMP.ID