SELECT * FROM OPENQUERY(CarSales,
'SELECT
NON EMPTY([Dim Clients].[Client Name].[Client Name]) ON COLUMNS
,EXCEPT([Dim Products].[Make].[Make], [Dim Products].[Make].UNKNOWNMEMBER) ON ROWS
FROM [Car Sales DW]
WHERE [Measures].[Cost Price]' );