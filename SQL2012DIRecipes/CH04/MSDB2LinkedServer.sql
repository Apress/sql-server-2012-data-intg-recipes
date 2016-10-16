USE master;
GO
EXECUTE master.dbo.sp_MSset_oledb_prop N'IBMDA400', N'AllowInProcess', 1 ;
GO
EXECUTE master.dbo.sp_MSset_oledb_prop N'IBMDA400', N'DynamicParameters', 1 ;
GO
Figure 4-15. The configuration panel for the IBM DB2 ODBC provider

EXECUTE master.dbo.sp_addlinkedserver
@server = 'MyDB2Server'
,@srvproduct = 'IBMDA400'
,@provider = 'MSDASQL'
,@datasrc = 'MyDB2' -- DSN, previously defined
,@catalog = 'CALIDRA02'
,@provstr = 'CMT = 0;SYSTEM = adam.calidra.co.uk' ;
EXECUTE master.dbo.sp_addlinkedsrvlogin
@rmtsrvname = N'MyDB2Server'
,@locallogin = NULL
,@useself = N'False'
,@rmtuser = N'Adam'
,@rmtpassword = N'Me4B0ss';