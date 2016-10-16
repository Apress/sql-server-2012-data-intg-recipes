SELECT
Marque AS TotalMonthlySalesPerMarque, [January], [February], [March], [April], [May],
[June], [July], [August], [September], [October], [November], [December]
FROM
(
SELECT
S.Marque
,DATENAME(month, I.InvoiceDate) AS SaleMonth
,L.SalePrice
FROM dbo.Stock S
INNER JOIN dbo.Invoice_Lines L
ON S.ID = L.StockID
INNER JOIN dbo.Invoice I
ON L.InvoiceID = I.ID
) AS SRC
PIVOT
(
SUM(SalePrice)
FOR SaleMonth IN ([January], [February], [March], [April], [May], [June], [July],
[August], [September], [October], [November], [December])
) AS PVT
;