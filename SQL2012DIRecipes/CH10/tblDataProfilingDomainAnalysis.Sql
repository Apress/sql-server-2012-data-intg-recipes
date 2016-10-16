CREATE TABLE CarSales_Staging.dbo.DataProfilingDomainAnalysis
(
ID INT IDENTITY(1,1) NOT NULL,
DataSourceObject NVARCHAR(150) NULL,
DataSourceColumn NVARCHAR(150) NULL,
DataSourceColumnData NVARCHAR(150) NULL,
DataSourceColumnResult NVARCHAR(150) NULL,
DateExecuted DATETIME NOT NULL DEFAULT (getdate())
) ;
GO