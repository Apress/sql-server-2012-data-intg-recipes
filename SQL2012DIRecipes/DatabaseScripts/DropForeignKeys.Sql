USE CarSales;
GO
If OBJECT_ID('FK_Client_Countries') IS NOT NULL
ALTER TABLE dbo.Client DROP CONSTRAINT FK_Client_Countries;
If OBJECT_ID('FK_Invoice_Client') IS NOT NULL
ALTER TABLE dbo.Invoice DROP CONSTRAINT FK_Invoice_Client;
If OBJECT_ID('FK_Invoice_Lines_Invoice') IS NOT NULL
ALTER TABLE dbo.Invoice_Lines DROP CONSTRAINT FK_Invoice_Lines_Invoice;
If OBJECT_ID('FK_Invoice_Lines_Stock') IS NOT NULL
ALTER TABLE dbo.Invoice_Lines DROP CONSTRAINT FK_Invoice_Lines_Stock;
If OBJECT_ID('FK_Stock_Colours') IS NOT NULL
ALTER TABLE dbo.Stock DROP CONSTRAINT FK_Stock_Colours;
GO