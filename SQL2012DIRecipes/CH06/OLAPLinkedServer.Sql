EXEC master.dbo.sp_addlinkedserver
@server = N'CarSales',
@srvproduct=N'MSOLAP',
@provider=N'MSOLAP',
@datasrc=N'ADAM02',
@catalog=N'CarSales_OLAP';