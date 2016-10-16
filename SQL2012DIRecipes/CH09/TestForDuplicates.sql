DECLARE @DupCount INT = 0;
SELECT @DupCount = SUM(TotalDups) AS Dups
FROM (
SELECT COUNT(*) AS TotalDups
FROM dbo.Client
GROUP BY ClientName, Country, Town, County, Address1, Address2, ClientType, ClientSize
HAVING COUNT(*) > 1
) A;
IF @DupCount > 0
BEGIN
-- Main code from Recipe 9-3 here
END;