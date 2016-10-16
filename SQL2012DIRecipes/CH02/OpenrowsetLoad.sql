SELECT CAST(BILLNO AS VARCHAR(5)) AS BILLNO
INTO MyTextImport
FROM OPENROWSET('MSDASQL', 'Driver = {Microsoft Text Driver (*.txt; *.csv)}; DefaultDir = C:\SQL 2012 DI Recipes\CH02;', ?
'SELECT INVOICENUMBER AS BILLNO FROM INVOICES.TXT WHERE CLIENTID = 1');

SELECT InvoiceNumber
INTO MyTextImport2
FROM OPENROWSET('MSDASQL', 'Driver = {Microsoft Text Driver (*.txt; *.csv)}; DefaultDir = C:\SQL2012DIRecipes\CH02;','select * from Invoices.txt');

SELECT InvoiceNumber
INTO MyTextImport3
FROM OPENROWSET('MSDASQL', 'Driver = {Microsoft Text Driver (*.txt; *.csv)}; DefaultDir = C:\SQL2012DIRecipes\CH02;','SELECT * FROM [In voices.txt]');

SELECT InvoiceNumber
INTO MyTextImport4
FROM OPENROWSET('MSDASQL', 'Driver = {Microsoft Access Text Driver (*.txt, *.csv)};', 'SELECT * FROM C:\SQL2012DIRecipes\CH02\Invoices.txt');

SELECT InvoiceNumber
INTO MyTextImport5
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 'Text;Database = C:\SQL2012DIRecipes\CH02;HDR = Yes','SELECT * FROM Invoices.txt');