CREATE TABLE CarSales_Staging.dbo.Client_SCD3
(
ClientID INT IDENTITY(1,1) NOT NULL,
BusinessKey INT NOT NULL,
ClientName VARCHAR(150) NULL,
Country VARCHAR(50) NULL,
Country_Prev1 VARCHAR(50) NULL,
Country_Prev1_ValidTo INT NULL,
Country_Prev2 VARCHAR(50) NULL,
Country_Prev2_ValidTo INT NULL,
) ;
GO