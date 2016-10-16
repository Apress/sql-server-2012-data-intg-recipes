SELECT
LEFT(ClientDataFixed,4) AS LeftCol
,SUBSTRING(ClientDataFixed,6,7) AS CentreCol
,RIGHT(ClientDataFixed,12) AS RightCol
FROM dbo.ClientSubset;