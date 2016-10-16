CREATE VIEW CarSales.dbo.vw_XMLTest
AS
SELECT XMLCol, SortKey FROM
(
SELECT ' < Root > ' AS XMLCol, 0 AS SortKey
UNION
SELECT
' < Client > '
+ ' < ID > ' + ISNULL(CAST(ID AS VARCHAR(12)),'') + '</ID > '
+ ' < ClientName > ' + ISNULL(ClientName,'') + '</ ClientName > '
+ '</Client > ' AS XMLCol
,1 AS SortKey
FROM dbo.Client
UNION
SELECT '</ROOT > ' AS XMLCol, 2 AS SortKey
) MainXML ;
GO