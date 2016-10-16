IF OBJECT_ID('TempDB..#Upsert') IS NOT NULL DROP TABLE #Upsert
SELECT ID, VersionStamp
INTO #Upsert
FROM ADAMREMOTE.CarSales.dbo.Invoice_Lines
-- Inserts
;
WITH Inserts_CTE
AS
(
SELECT ID
FROM #Upsert U
WHERE ID NOT IN (
SELECT ID FROM dbo.Invoice_Lines WITH (NOLOCK))
)
INSERT INTO dbo.Invoice_Lines
(
ID
,InvoiceID
,SalePrice
,StockID
,VersionStamp
)
SELECT
SRC_I.ID
,InvoiceID
,SalePrice
,StockID
,VersionStamp
FROM ADAMREMOTE.CarSales.dbo.Invoice_Lines SRC_I WITH (NOLOCK)
INNER JOIN Inserts_CTE CTE_I
ON SRC_I.ID = CTE_I.ID
-- Updates
;
WITH Updates_CTE
AS

(
SELECT S_U.ID
FROM dbo.Invoice_Lines S_U WITH (NOLOCK)
INNER JOIN #Upsert U WITH (NOLOCK)
ON S_U.ID = U.ID
WHERE S_U.VersionStamp<> U.VersionStamp
)
UPDATE DST_U
SET DST_U.InvoiceID = SRC_U.InvoiceID
,DST_U.SalePrice = SRC_U.SalePrice
,DST_U.StockID = SRC_U.StockID
,DST_U.VersionStamp = SRC_U.VersionStamp
FROM dbo.Invoice_Lines DST_U
INNER JOIN ADAMREMOTE.CarSales.dbo.Invoice_Lines SRC_U
ON SRC_U.ID = DST_U.ID
INNER JOIN Updates_CTE CTE_U
ON DST_U.ID = CTE_U.ID
-- DELETES
DELETE FROM dbo.Invoice_Lines
WHERE ID NOT IN (SELECT ID FROM #Upsert)