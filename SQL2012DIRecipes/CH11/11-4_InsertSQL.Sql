SELECT SRC.ID, SRC.InvoiceID, SRC.StockID, SRC.SalePrice, SRC.HashData
FROM dbo.Invoice_Lines SRC
INNER JOIN TMP_Inserts TMP
ON SRC.ID = TMP.ID