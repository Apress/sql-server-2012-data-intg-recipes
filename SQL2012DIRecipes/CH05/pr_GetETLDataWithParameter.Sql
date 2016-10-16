CREATE PROCEDURE CarSales.dbo.pr_GetETLDataWithParameter
(
@ID INT
)

AS

SELECT
ClientName, Town
FROM dbo.Client
WHERE ID = @ID
;
GO