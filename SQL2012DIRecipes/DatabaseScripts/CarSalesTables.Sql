USE CarSales;
GO
If OBJECT_ID('dbo.Client') IS NOT NULL DROP TABLE dbo.Client
CREATE TABLE dbo.Client
(
ID int IDENTITY(1,1) NOT NULL,
ClientName NVARCHAR(150) NULL,
Address1 VARCHAR(50) NULL,
Address2 VARCHAR(50) NULL,
Town VARCHAR(50) NULL,
County VARCHAR(50) NULL,
PostCode VARCHAR(10) NULL,
Country TINYINT NULL,
ClientType VARCHAR(20) NULL,
ClientSize VARCHAR(10) NULL,
ClientSince SMALLDATETIME NULL,
IsCreditWorthy BIT NULL,
DealerGroup HIERARCHYID NULL,
MapPosition GEOGRAPHY NULL
) ;
GO
If OBJECT_ID('dbo.Colours ') IS NOT NULL DROP TABLE dbo.Colours
CREATE TABLE dbo.Colours
(
ColourID TINYINT NOT NULL,
Colour NVARCHAR(50) NULL
) ;
GO
CREATE TABLE dbo.Countries
(
CountryID TINYINT NOT NULL,
CountryName_EN NVARCHAR(50) NULL,
CountryName_Local NVARCHAR(50) NULL
) ;
GO
If OBJECT_ID('dbo.Invoice ') IS NOT NULL DROP TABLE dbo.Invoice
CREATE TABLE dbo.Invoice
(
ID int IDENTITY(1,1) NOT NULL,
InvoiceNumber NVARCHAR(50) NOT NULL CONSTRAINT DF_Invoice_InvoiceNumber DEFAULT (newid()),
ClientID INT NULL,
InvoiceDate DATETIME NULL,
TotalDiscount NUMERIC(18, 2) NULL,
DeliveryCharge SMALLMONEY NULL
) ;
GO
If OBJECT_ID('dbo.Invoice_Lines ') IS NOT NULL DROP TABLE dbo.Invoice_Lines
CREATE TABLE dbo.Invoice_Lines
(
ID int IDENTITY(1,1) NOT NULL,
InvoiceID INT NULL,
StockID BIGINT NULL,
SalePrice MONEY NULL,
Timestamp TIMESTAMP NULL,
HashData AS
(hashbytes('SHA1',(((CONVERT(varchar(20),InvoiceID)+CONVERT(varchar(20),StockID))
+CONVERT(varchar(20),isnull(SalePrice,(0))))
+CONVERT(varchar(20),isnull(DateUpdated,'2000-01-01')))
+CONVERT(varchar(20),isnull(LineItem,(0))))),
DateUpdated DATETIME2(0) NULL,
LineItem SMALLINT NULL
)
GO
If OBJECT_ID('dbo.Stock ') IS NOT NULL DROP TABLE dbo.Stock
CREATE TABLE dbo.Stock
(
ID bigint IDENTITY(1,1) NOT NULL,
Make VARCHAR(50) NULL,
Marque NVARCHAR(50) NULL,
Model VARCHAR(50) NULL,
Colour TINYINT NULL,
Product_Type VARCHAR(50) NULL,
Vehicle_Type VARCHAR(20) NULL,
Cost_Price NUMERIC(18, 2) NULL,
Registration_Date DATE NULL,
CarPhoto VARBINARY(max) NULL,
CarPhotoType VARCHAR(5) NULL,
CarPhotoDirectory VARCHAR(150) NULL,
CarDocumentation NVARCHAR(max) NULL,
IndustryDefinition XML NULL,
DateReserved DATETIME2(7) NULL,
Weight float NULL,
Mileage NUMERIC(32, 4) NULL,
Chassis UNIQUEIDENTIFIER NULL CONSTRAINT DF_Stock_Chassis DEFAULT (newid())
) ;
GO