UPDATE DST
SET
DST.ClientName = SRC.ClientName
,DST.Country = SRC.Country
,DST.Town = SRC.Town
,DST.County = SRC.County
,DST.Address1 = SRC.Address1
,DST.Address2 = SRC.Address2
,DST.ClientType = SRC.ClientType
,DST.ClientSize = SRC.ClientSize
FROM dbo.Client DST
INNER JOIN Tmp_Updates SRC
ON DST.ID = SRC.ID