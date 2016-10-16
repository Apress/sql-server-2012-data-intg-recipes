EXECUTE master.dbo.sp_addlinkedserver TXT_INVOICES, ' ', 'Microsoft.ACE.OLEDB.12.0','C:\SQL2012DIRecipes\CH02', NULL, 'Text';

EXECUTE master.dbo.sp_addlinkedsrvlogin 'TXT_INVOICES', false, NULL, 'admin';

EXECUTE master.dbo.sp_addlinkedserver 'TXT_INVOICES', ' ', 'MSDASQL', 'MSTEXT';


INSERT INTO Text_OpenrowsetInsert (ID, InvoiceNumber, ClientID, TotalDiscount,DeliveryCharge) ;
SELECT ID, InvoiceNumber, ClientID, TotalDiscount, DeliveryCharge
FROM TXT_INVOICES...Invoices#txt;



INSERT INTO Text_OpenrowsetInsert (ID, InvoiceNumber, ClientID, TotalDiscount,DeliveryCharge)
SELECT ID, InvoiceNumber, ClientID, TotalDiscount, DeliveryCharge
FROM OPENQUERY(TXT_INVOICES,'SELECT * FROM Invoices#txt');

EXECUTE master.dbo.sp_addlinkedserver
@SERVER = 'TXTACCESS',
@PROVIDER = 'Microsoft.Jet.OLEDB.4.0',
@SRVPRODUCT = 'Jet',
@DATASRC = 'C:\SQL2012DIRecipes\CH02\',
@PROVSTR = 'Text'

