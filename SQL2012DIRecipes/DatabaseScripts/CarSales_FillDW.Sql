CREATE procedure dbo.pr_FillDW
AS
-- Geography
TRUNCATE TABLE dbo.Dim_Geography

INSERT INTO dbo.Dim_Geography
(
Country
,State_County
,Town
)
SELECT DISTINCT
C.CountryName_EN
,L.County
,L.Town
FROM CarSales_Book.dbo.Countries C
INNER JOIN CarSales_Book.dbo.Client L
ON C.CountryID = L.Country
-- Clients
TRUNCATE TABLE dbo.Dim_Clients
INSERT INTO dbo.Dim_Clients
(
Client_Name
,Client_Size
,Client_Type
)
SELECT DISTINCT ClientName, ClientSize, ClientType
FROM CarSales_Book.dbo.Client
-- Products
TRUNCATE TABLE dbo.Dim_Products
INSERT INTO dbo.Dim_Products
(
Product_Type
,Make
,Marque
,Model
,Colour
,Vehicle_Type
)
SELECT DISTINCT S.Product_Type, S.Make, S.Marque, S.Model, C.Colour, S.Vehicle_Type
FROM CarSales_Book.dbo.Colours C
INNER JOIN CarSales_Book.dbo.Stock S
ON C.ColourID = S.Colour
-- Fact table

TRUNCATE TABLE dbo.Fact_Sales
INSERT INTO dbo.Fact_Sales
(
Sale_Price
,InvoiceDate
,Total_Discount
,Delivery_Cost
,Cost_Price
,Make_X
,Marque_X
,Model_X
,Colour_X
,Product_Type_X
,Vehicle_Type_X
,ClientName_X
,Country_X
,Town_X
,County_X
)
SELECT DISTINCT
L.SalePrice, I.InvoiceDate, I.TotalDiscount, I.DeliveryCharge, S.Cost_Price, S.Make,
S.Marque, S.Model, C.Colour, S.Product_Type, S.Vehicle_Type, CL.ClientName, CR.CountryName_EN,
CL.Town, CL.County
FROM CarSales_Book.dbo.Colours C
INNER JOIN CarSales_Book.dbo.Stock S
ON C.ColourID = S.Colour
INNER JOIN CarSales_Book.dbo.Invoice_Lines L
ON S.ID = L.StockID
INNER JOIN CarSales_Book.dbo.Invoice I
ON L.InvoiceID = I.ID
INNER JOIN CarSales_Book.dbo.Client CL
ON I.ClientID = CL.ID
INNER JOIN CarSales_Book.dbo.Countries CR
ON CL.Country = CR.CountryID
-- Set GeographyID
UPDATE F
SET F.Geography_ID = G.ID
FROM dbo.Fact_Sales F
INNER JOIN dbo.Dim_Geography G
ON F.Country_X = G.Country
AND F.County_X = G.State_County
AND F.Town_X = G.Town

-- Set ProductID
UPDATE F
SET F.Product_ID = P.ID
FROM dbo.Fact_Sales F
INNER JOIN dbo.Dim_Products P
ON F.Product_Type_X = P.Product_Type
AND F.Make_X = P.Make
AND F.Marque_X = P.Marque
AND F.Model_X = P.Model
AND F.Vehicle_Type_X = P.Vehicle_Type
-- Set Client ID
UPDATE F
SET F.Client_ID = C.ID
FROM dbo.Fact_Sales F
INNER JOIN dbo.Dim_Clients C
ON F.ClientName_X = C.Client_Name
GO