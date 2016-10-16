UPDATE D

SET
D.ClientName = S.ClientName
,D.Address1 = S.Address1
,D.Address2 = S.Address2
,D.Town = S.Town
,D.County = S.County
,D.PostCode = S.PostCode
,D.Country = S.Country
,D.ClientType = S.ClientType
,D.ClientSize = S.ClientSize
,D.ClientSince = S.ClientSince
,D.IsCreditWorthy = S.IsCreditWorthy
,D.DealerGroup = S.DealerGroup
,D.MapPosition = S.MapPosition
FROM CarSales.dbo.client D
INNER JOIN dbo.CDC_Client_Updates S
ON S.ID = D.ID