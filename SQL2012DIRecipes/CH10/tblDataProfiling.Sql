CREATE TABLE CarSales_Staging.dbo.DataProfiling
(
ID int IDENTITY(1,1) NOT NULL,
DateExecuted DATETIME NULL CONSTRAINT DF_Log_DataProfiling_DateExecuted
DEFAULT (getdate()),
DataSourceObject varchar(250) NULL,
DataSourceColumn varchar(250) NULL,
ProfileName varchar(50) NULL,
ProfileResult numeric(22, 4) NULL
) ;
GO