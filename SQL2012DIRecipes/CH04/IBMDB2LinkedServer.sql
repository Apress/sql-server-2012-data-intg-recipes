EXECUTE master.dbo.sp_addlinkedserver
@server = N'DB2',
@srvproduct = N'Microsoft OLE DB Provider for DB2',
@catalog = N'DB2',
@provider = N'DB2OLEDB',
@provstr = N'Initial Catalog = CarSales;
Data Source = DB2;
HostCCSID = 1275;
Network Address = 257.257.257.257;
Network Port = 50000;
Package Collection = admin;
Default Schema = admin;