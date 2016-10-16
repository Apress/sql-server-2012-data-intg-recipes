CREATE TABLE CarSales_Staging.dbo.CarPhotos
(
ID int IDENTITY(1,1) NOT NULL,
FileName varchar(50) NULL,
FileExtension varchar(10) NULL,
DirectoryName varchar(150) NULL,
FileSize bigint NULL,
DateFileCreated datetime2(7) NULL,
DateFileModified datetime2(7) NULL,
ItemImage varbinary(max) NULL,
UNIQUE NONCLUSTERED (ID ASC )
);
GO