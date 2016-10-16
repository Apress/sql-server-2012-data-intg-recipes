EXECUTE master.dbo sp_addlinkedserver
@server = N'SQLLinkedServer',
@srvproduct = N' ',
@provider = N'SQLNCLI',
@datasrc = N'ADAM02\AdamRemote',
@catalog = N'CarSales';


SELECT
ClientName, Town
INTO dbo.CarSales
FROM SQLLinkedServer.CarSales.dbo.Client;




EXECUTE master.dbo.sp_addlinkedsrvlogin @rmtsrvname = N'SQLLinkedServer', @locallogin = NULL, @useself = N'False', @rmtuser = N'Adam', @rmtpassword = N'Me4B0ss';


EXECUTE sp_serveroption @server='SQLLinkedServer', @optname='rpc out', @optvalue='TRUE';



INSERT INTO dbo.Client (ClientName, Town )
EXEC ('SELECT ClientName, Town FROM CarSales.dbo.Client') AT SQLLinkedServer;



DECLARE @ID INT = 2
INSERT INTO dbo.Client (ClientName, Town)
EXEC ('SELECT ClientName, Town FROM CarSales.dbo.Client WHERE ID=' + @ID) AT SQLLinkedServer;





