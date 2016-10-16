CREATE TABLE Text_OpenrowsetInsert
(
ID
,InvoiceNumber INT
,ClientID INT
,TotalDiscount NUMERIC (18,2)
,DeliveryCharge NUMERIC (18,2)
);
GO


INSERT INTO Text_OpenrowsetInsert ( ID, InvoiceNumber, ClientID, TotalDiscount, DeliveryCharge)
SELECT F1,F2,F3,F4,F5
FROM OpenDataSource ('Microsoft.ACE.OLEDB.12.0',
'Data Source = C:\SQL2012DIRecipes\CH02;Extended Properties = "Text;HDR = NO;"'
)... Invoices#txt;


INSERT INTO Text_OpenrowsetInsert ( ID, InvoiceNumber, ClientID,
TotalDiscount, DeliveryCharge)
SELECT F1,F2,F3,F4,F5
FROM OPENDATASOURCE ( 'Microsoft.Jet.OLEDB.4.0',
'Data Source = C:\SQL2012DIRecipes\CH02;Extended Properties = "Text;HDR = YES;"'
)...Invoices#txt;

SELECT F1
FROM OPENDATASOURCE (
'Microsoft.Jet.OLEDB.4.0',
'Data Source = C:\SQL2012DIRecipes\CH02;Extended Properties = "Text;HDR = NO;"'
)...Invoices#txt

SELECT ID, InvoiceNumber, ClientID, TotalDiscount, DeliveryCharge
FROM OPENDATASOURCE('SQLOLEDB', 'DSN = MyDSN;')...Invoices#txt


