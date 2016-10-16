CREATE TABLE CarSales_Staging.dbo.BatchFileLoad
(
ID int IDENTITY(1,1) NOT NULL,
FileName VARCHAR (250) NULL,
IsToload BIT NULL,
IsLoaded BIT NULL,
FileSize BIGINT NULL,
CreationTime DATETIME NULL,
FileExtension VARCHAR (5) NULL,
DirectoryName VARCHAR (250) NULL,
LastWriteTime DATETIME NULL
) ;
GO