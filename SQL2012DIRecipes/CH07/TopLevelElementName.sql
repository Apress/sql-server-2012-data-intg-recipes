SELECT
C.ID
,C.ClientName
,C.Country
FROM dbo.Client C
FOR XML PATH('Client');