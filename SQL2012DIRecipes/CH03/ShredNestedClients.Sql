SELECT ID, ClientName, Country, TotalDiscount
FROM OPENXML(@DocID, 'CarSales/Client', 2)
WITH (
ID VARCHAR(50) 'ID'
,ClientName VARCHAR(50) 'ClientName'
,Country VARCHAR(10)'Country'
,TotalDiscount NUMERIC(18,2) 'Invoice/TotalDiscount'
)