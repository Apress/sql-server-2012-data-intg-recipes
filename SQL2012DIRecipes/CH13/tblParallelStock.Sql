CREATE TABLE CarSales_Staging.dbo.ParallelStock
(
ID bigint IDENTITY(1,1) NOT NULL,
Make VARCHAR (50) NULL,
Marque NVARCHAR(50) NULL,
Model VARCHAR (50) NULL,
Colour TINYINT NULL,
Product_Type VARCHAR (50) NULL,
Vehicle_Type VARCHAR (20) NULL,
Cost_Price NUMERIC(18, 2) NULL
)