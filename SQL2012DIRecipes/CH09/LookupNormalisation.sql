SELECT DISTINCT DNS.ClientName, DNS.Country, DNS.Town, C.ID AS CountryID
FROM CarSales_Staging.dbo.DenormalisedSales DNS
INNER JOIN CarSales_Staging.dbo.Countries C
ON DNS.Country = C.CountryCode
WHERE NOT EXISTS (
SELECT ID
FROM dbo.Client
WHERE ClientName = DNS.ClientName
AND Country = DNS.Country
AND Town = DNS.Town
);