CREATE PROCEDURE CarSales.dbo.pr_GetChunkedXML
(
@ChunkID INT
)
AS
SELECT A.XmlOut
FROM
(
SELECT
S.ID
,InvoiceID
,StockID
,SalePrice
,DateUpdated
FROM dbo.Invoice_Lines S
INNER JOIN ##Tmp_ChunkDef Tmp 
ON S.ID = Tmp.ID
WHERE Tmp.ChunkID = @ChunkID
FOR XML PATH ('Invoice_Lines'), TYPE
) A (XmlOut);