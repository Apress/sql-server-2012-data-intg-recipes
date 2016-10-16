CREATE TABLE CarSales_Staging.dbo.DocumentList
(
ID int IDENTITY(1,1) NOT NULL,
ExternalFileName nvarchar(255) NULL,
FileType char(10) NULL,
ExternalFileDirectory nvarchar(255) NULL
);
GO