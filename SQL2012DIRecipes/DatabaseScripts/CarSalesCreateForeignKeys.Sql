USE CarSales;
GO
If OBJECT_ID('FK_Client_Countries') IS NULL
ALTER TABLE dbo.Client WITH CHECK ADD CONSTRAINT FK_Client_Countries FOREIGN KEY(Country) REFERENCES dbo.Countries (CountryID);
ALTER TABLE dbo.Client CHECK CONSTRAINT FK_Client_Countries;
If OBJECT_ID('FK_Invoice_Client') IS NULL
ALTER TABLE dbo.Invoice WITH CHECK ADD CONSTRAINT FK_Invoice_Client FOREIGN KEY(ClientID) REFERENCES dbo.Client (ID);
ALTER TABLE dbo.Invoice CHECK CONSTRAINT FK_Invoice_Client;
If OBJECT_ID('FK_Invoice_Lines_Invoice') IS NULL
ALTER TABLE dbo.Invoice_Lines WITH NOCHECK ADD CONSTRAINT FK_Invoice_Lines_Invoice FOREIGN KEY(InvoiceID) REFERENCES dbo.Invoice (ID);
ALTER TABLE dbo.Invoice_Lines CHECK CONSTRAINT FK_Invoice_Lines_Invoice;
If OBJECT_ID('FK_Invoice_Lines_Stock') IS NULL
ALTER TABLE dbo.Invoice_Lines WITH NOCHECK ADD CONSTRAINT FK_Invoice_Lines_Stock FOREIGN KEY(StockID) REFERENCES dbo.Stock (ID);
ALTER TABLE dbo.Invoice_Lines CHECK CONSTRAINT FK_Invoice_Lines_Stock;
If OBJECT_ID('FK_Stock_Colours') IS NULL
ALTER TABLE dbo.Stock WITH CHECK ADD CONSTRAINT FK_Stock_Colours FOREIGN KEY(Colour) REFERENCES dbo.Colours (ColourID);
ALTER TABLE dbo.Stock CHECK CONSTRAINT FK_Stock_Colours;
GO