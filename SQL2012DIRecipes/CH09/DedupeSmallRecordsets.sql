WITH Dedupe_CTE (RowNo, ClientName, Country, Town, County, Address1, Address2,
ClientType, ClientSize)
AS
(
SELECT ROW_NUMBER() OVER (PARTITION BY ClientNameORDER BY ClientNameDESC) AS RowNo,
ClientName, Country, Town, County, Address1, Address2, ClientType, ClientSize
FROM dbo.Client
)
DELETE FROM Dedupe_CTE WHERE RowNo > 1;