USE master
GO
IF db_id('CarSales_DW') IS NOT NULL
DROP DATABASE CarSales_DW';
GO


CREATE DATABASE CarSales_DW
CONTAINMENT = NONE
ON PRIMARY
( NAME = N'CarSales_DW', FILENAME = N'C:\SQLDIRecipes\Databases\CarSales_DW.mdf' , SIZE = 33792KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
LOG ON
( NAME = N'CarSales_DW_log', FILENAME = N'C:\SQLDIRecipes\Databases\CarSales_DW_log.ldf' , SIZE = 4224KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE CarSales_DW SET COMPATIBILITY_LEVEL = 110
GO
ALTER DATABASE CarSales_DW SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE CarSales_DW SET RECOVERY SIMPLE
GO
ALTER DATABASE CarSales_DW SET READ_WRITE
GO
USE CarSales_DW
GO
CREATE TABLE dbo.Fact_Sales
(
SalesID int IDENTITY(1,1) NOT NULL,
Sale_Price numeric(18, 2) NULL,
InvoiceDate datetime NULL,
Total_Discount numeric(18, 2) NULL,
Delivery_Cost numeric(18, 2) NULL,
Cost_Price decimal(18, 2) NULL,
Make_X nvarchar(50) NULL,
Marque_X nvarchar(50) NULL,
Model_X nvarchar(50) NULL,
Colour_X nvarchar(50) NULL,
Product_Type_X nvarchar(50) NULL,
Vehicle_Type_X nvarchar(50) NULL,
ClientName_X nvarchar(150) NULL,
Country_X varchar(50) NULL,
Town_X nvarchar(50) NULL,
County_X nvarchar(50) NULL,
Client_ID int NULL,
Geography_ID int NULL,
Product_ID int NULL
) ;
GO
CREATE TABLE dbo.Dim_Products
(
ID int IDENTITY(1,1) NOT NULL,
Product_Type nvarchar(50) NULL,
Make nvarchar(50) NULL,
Marque nvarchar(50) NULL,
Colour nvarchar(50) NULL,
Vehicle_Type nvarchar(50) NULL,
Model nvarchar(50) NULL,
CONSTRAINT PK_Dim_Products PRIMARY KEY CLUSTERED
(
ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ;
GO
CREATE TABLE dbo.Dim_Geography
(
ID int IDENTITY(1,1) NOT NULL,
Country nvarchar(50) NULL,
State_County nvarchar(50) NULL,
Town nvarchar(50) NULL,
CONSTRAINT PK_Dim_Geography PRIMARY KEY CLUSTERED
(
ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ;
GO
CREATE TABLE dbo.Dim_Clients
(
ID int IDENTITY(1,1) NOT NULL,
Client_Name nvarchar(150) NULL,
Client_Size varchar(10) NULL,
Client_Type varchar(10) NULL,
CONSTRAINT PK_Dim_Clients PRIMARY KEY CLUSTERED
(
ID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ;
GO