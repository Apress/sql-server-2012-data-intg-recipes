EXEC master.dbo.sp_addlinkedserver @server = N'OLAPSERVER', @srvproduct = N'Analysis Services', @provider = N'MSOLAP', @datasrc = N'localhost'

INSERT INTO SSASData (Client_Name, Sale_Price, Cost_Price)
SELECT
CS.[[Dim Clients]].[Client Name]].[Client Name]].[MEMBER_CAPTION]]] AS Client_Name
,CS.[[Measures]].[Sale Price]]] AS Sale_Price
,CS.[[Measures]].[Cost Price]]] AS Cost_Price
FROM OPENQUERY(OLAPSERVER,
'SELECT
{[Measures].[Sale Price], [Measures].[Cost Price]} ON COLUMNS,
NONEMPTY(EXCEPT([Dim Clients].[Client Name].MEMBERS, [Dim Clients].[Client Name].
[All])) ON ROWS
FROM [Car Sales DW]
WHERE [Dim Products].[ProductVehicleHierarchy].[Product Type].&[Van]'
) AS CS;