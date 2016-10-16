CREATE TABLE CarSales_Staging.dbo.StockInDollars
(
ID bigint NULL,
Make varchar(50) NULL,
Marque nvarchar(50) NULL,
Mileage numeric(32, 4) NULL,
Cost_PriceGBP numeric(18, 2) NULL,
Cost_PriceUSD numeric(18, 2) NULL,
ExchangeRate float NULL
) ;
GO