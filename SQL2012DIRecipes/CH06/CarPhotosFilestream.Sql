CREATE TABLE dbo.CarPhotosFS
(
ID int IDENTITY(1,1) NOT NULL,
ItemID uniqueidentifier ROWGUIDCOL NOT NULL,
FileName varchar(50) NULL,
FileExtension varchar(10) NULL,
DirectoryName varchar(150) NULL,
FileSize bigint NULL,
DateFileCreated datetime2(7) NULL,
DateFileModified datetime2(7) NULL,
ItemImage varbinary(max) FILESTREAM NULL,
UNIQUE NONCLUSTERED
(
ItemID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON PRIMARY
) ON PRIMARY FILESTREAM_ON CarSalesFS