TempDB..##TMP_Deletes

TempDB..##TMP_Updates

TempDB..##TMP_Inserts

TempDB..##Invoice_Lines_Updates


SELECT SRC.ID, SRC.InvoiceID,
SRC.StockID, SRC.SalePrice,
SRC.HashData
FROM dbo.Invoice_Lines SRC
INNER JOIN TempDB..##TMP_Inserts TMP
ON SRC.ID = TMP.ID


SELECT SRC.ID, SRC.InvoiceID, SRC.StockID,
SRC.SalePrice, SRC.HashData
FROM dbo.Invoice_Lines SRC
INNER JOIN TempDB..##TMP_Updates TMP
ON SRC.ID = TMP.ID