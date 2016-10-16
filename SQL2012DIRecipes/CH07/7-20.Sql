EXECUTE master.dbo.sp_addlinkedserver
@server = N'Access'
,@srvproduct = N'Access'
,@provider = N'Microsoft.ACE.OLEDB.12.0'
,@datasrc = NC:\SQL2012DIRecipes\CH07\TestAccess.mdb'

EXECUTE master.dbo.sp_addlinkedsrvlogin
@rmtsrvname = N'Access',@useself = N'False',@locallogin = NULL,@rmtuser = NULL,
@rmtpassword = NULL

INSERT INTO Access...ClientExport (ID, ClientName)
SELECT ID, ClientName FROM dbo.Client