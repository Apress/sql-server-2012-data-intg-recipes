USE CarSales_Staging
GO
CREATE TABLE dbo.Client_BCP
(
ID int NOT NULL,
ClientName nvarchar(150) NULL,
Town varchar(50) NULL,
County varchar(50) NULL,
ClientSize varchar(10) NULL,
ClientSince smalldatetime NULL
) ;
GO