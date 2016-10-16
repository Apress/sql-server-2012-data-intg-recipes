CREATE PROCEDURE CarSales.dbo.pr_GetETLData
AS
SELECT
ClientName, Town
FROM dbo.Client
;
GO