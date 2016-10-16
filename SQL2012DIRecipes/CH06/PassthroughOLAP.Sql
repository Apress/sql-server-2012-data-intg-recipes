INSERT INTO dbo.SalesAnalysis (MakeOfCar, BauhausMotors, JohnSmith)
SELECT OLP."[Dim Products].[Make].[Make].[MEMBER_CAPTION]" AS MakeOfCar
,"[Dim Clients].[Client Name].&[Bauhaus Motors]" AS [Bauhaus Motors]
,"[Dim Clients].[Client Name].&[John Smith]" AS [John Smith]
FROM OPENROWSET('MSOLAP','DATASOURCE = ADAM02; Initial Catalog = CarSalesCube;',
'SELECT NONEMPTY([Dim Clients].[Client Name].Children) ON COLUMNS
,NONEMPTY([Dim Products].[Make].children) ON ROWS
FROM [Car Sales DW]
WHERE [Measures].[Cost Price]') AS OLP;