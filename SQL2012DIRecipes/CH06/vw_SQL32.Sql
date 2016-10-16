CREATE VIEW vw_SQL32
AS
SELECT theText from Access. . .Client;
GO

EXECUTE master.dbo.sp_addlinkedserver @server = 'ADAM32', @srvproduct = '', @provider = 'SQLNCLI', @datasrc = 'ADAM02\SQL32Bit';

SELECT ID, Marque FROM ADAM32.CarSales32.dbo.vw_SQL32;