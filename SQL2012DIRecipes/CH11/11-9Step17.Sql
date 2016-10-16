SELECT SRC.ID
,SRC.InvoiceID
,SRC.StockID
,SRC.SalePrice
,SRC.DateUpdated
FROM dbo.Invoice_Lines SRC
INNER JOIN dbo.DeltaTracking TRK
ON SRC.ID = TRK.RecordID
WHERE TRK.DeltaOperation = 'U'
AND ObjectID = OBJECT_ID('dbo.Invoice_Lines')