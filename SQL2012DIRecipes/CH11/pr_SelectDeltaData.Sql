CREATE PROCEDURE CarSales_Staging.dbo.pr_SelectDeltaData
(
@DeltaSet DeltaIDs READONLY
)
AS
SELECT
S.ID
,S.InvoiceID
,S.StockID
,S.SalePrice
,CAST(S.HashData AS VARCHAR(50)) AS HashData
FROM dbo.Invoice_Lines S
INNER JOIN @DeltaSet D
ON S.ID = D.ID;
GO