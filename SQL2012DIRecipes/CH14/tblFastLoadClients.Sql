CREATE TABLE CarSales_Staging.dbo.FastLoadClients
(
ID INT,
ClientName NVARCHAR (150),
Address1 VARCHAR (50),
Address2 VARCHAR (50),
Town VARCHAR (50),
County VARCHAR (50),
PostCode VARCHAR (10),
ClientType VARCHAR (20),
ClientSize VARCHAR(10),
ClientSince DATETIME,
IsCreditWorthy BIT,
DealerGroup BINARY(892)
) ;
GO