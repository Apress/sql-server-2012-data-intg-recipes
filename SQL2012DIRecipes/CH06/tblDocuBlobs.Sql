CREATE TABLE CarSales_Staging.dbo.DocuBlobs
(
ID int IDENTITY(1,1) NOT NULL,
ExternalFileName nvarchar(255) NULL,
FileData varbinary(max) NULL,
FileType char(10) NULL,
ExternalFileDirectory nvarchar(255) NULL
) ;
GO