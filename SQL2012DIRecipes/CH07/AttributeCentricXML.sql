SELECT
C.ID '@ID'
,C.ClientName '@ClientName'
,C.Country '@Country'
FROMdbo.Client C
FOR XML PATH('Client'), ROOT('CarSales');