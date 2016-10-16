INSERT INTO OPENROWSET('Microsoft.ACE.OLEDB.12.0','Text;Database = C:\CookBook\;', 'SELECT Client_Name, Sale_Price, Cost_Price FROM InsertMDXFile.txt')
SELECT
CS.[[Dim Clients]].[Client Name]].[Client Name]].[MEMBER_CAPTION]]] AS Client_Name
,CS.[[Measures]].[Sale Price]]] AS Sale_Price
,CS.[[Measures]].[Cost Price]]] AS Cost_Price
FROM OPENROWSET
(
'MSOLAP','DATASOURCE = localhost; Initial Catalog = CarSales_OLAP;',
'SELECT
{[Measures].[Sale Price], [Measures].[Cost Price]} ON COLUMNS,
NONEMPTY(EXCEPT([Dim Clients].[Client Name].MEMBERS, [Dim Clients].[Client Name].[All])) ON ROWS
FROM [Car Sales DW]'
) AS CS;