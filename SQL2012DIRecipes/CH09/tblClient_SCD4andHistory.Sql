CREATE TABLE CarSales_Staging.dbo.Client_SCD4_History
(
ClientID INT IDENTITY(1,1) NOT NULL,
BusinessKey INT NOT NULL,
ClientName VARCHAR(150) NULL,
Country VARCHAR(50) NULL,
Town VARCHAR(50) NULL,
County VARCHAR(50) NULL,
Address1 VARCHAR(50) NULL,
Address2 VARCHAR(50) NULL,
ClientType VARCHAR(20) NULL,
ClientSize VARCHAR(10) NULL,
ValidTo INT,
HistoricalVersion INT
) ;
GO


CREATE TABLE CarSales_Staging.dbo.Client_SCD4
(
ClientID INT IDENTITY(1,1) NOT NULL,
BusinessKey INT NOT NULL,
ClientName VARCHAR(150) NULL,
Country VARCHAR(50) NULL,
) ;
GO