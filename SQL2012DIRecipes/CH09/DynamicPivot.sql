DECLARE @ColumnList VARCHAR(8000)
SELECT
@ColumnList = LEFT(TR.ColList, LEN(TR.ColList)-1)
FROM
(
SELECT QUOTENAME(DATENAME(month, InvoiceDate)) + ',' AS [text()]
FROM dbo.Invoice
GROUP BY DATENAME(month, InvoiceDate), MONTH(InvoiceDate)
ORDER BY MONTH(InvoiceDate)
FOR XML PATH('')
) TR (ColList);
DECLARE @TransposeSQL VARCHAR(MAX) = '
SELECT
Marque AS TotalMonthlySalesPerMarque, '+ @ColumnList + '
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
FOR SaleMonth IN ('+ @ColumnList + ')
) AS PVT
;'
EXECUTE CarSales.dbo.sp_executesql @statement = @TransposeSQL;