SELECT ClientName, County, Country FROM dbo.Client
UNION ALL
SELECT ClientName, County, Country FROM dbo.Client1;



SELECT ClientName, County, Country FROM dbo.Client
UNION
SELECT ClientName, County, Country FROM dbo.Client1;


SELECT ClientName, Country, Country FROM dbo.Client
INTERSECT
SELECT ClientName, County, Country FROM dbo.Client1;