USE CarSales_Staging;
GO
CREATE TABLE dbo.DataProfiling_ColumnValueDistribution
(
ProfileRequestID NVARCHAR(255) NULL,
NumberOfDistinctValues INT NULL,
ColumnValueDistributionProfile_Id BIGINT NOT NULL,
DateAdded DATETIME NOT NULL DEFAULT GETDATE(),
ID int IDENTITY(1,1) NOT NULL
) ;
GO
CREATE TABLE dbo.DataProfiling_ColumnStatistics
(
ProfileRequestID NVARCHAR(255) NULL,
MinValue DECIMAL(28, 10) NULL,
MaxValue DECIMAL(28, 10) NULL,
Mean DECIMAL(28, 10) NULL,
StdDev DECIMAL(28, 10) NULL,
ID int IDENTITY(1,1) NOT NULL,
DateAdded DATETIME NOT NULL DEFAULT GETDATE()
) ;
GO
CREATE TABLE dbo.DataProfiling_ColumnNulls
(
ProfileRequestID NVARCHAR(255) NULL,
NullCount TINYINT NULL,
ID int IDENTITY(1,1) NOT NULL,
DateAdded DATETIME NOT NULL DEFAULT GETDATE()
) ;
GO
CREATE TABLE dbo.DataProfiling_ColumnLength
(
ProfileRequestID NVARCHAR(255) NULL,
ColumnLengthDistributionProfile_ID BIGINT NULL,
MinLength TINYINT NULL,
MaxLength TINYINT NULL,
ID int IDENTITY(1,1) NOT NULL,
DateAdded DATETIME NOT NULL DEFAULT GETDATE()
) ;
GO
CREATE TABLE dbo.DataProfiling_ValueDistributionItem
(
Value NVARCHAR(255) NULL,
Count INT NULL,
ValueDistribution_Id BIGINT NOT NULL
) ;
GO
CREATE TABLE dbo.DataProfiling_LengthDistributionItem
(
Length tinyint NOT NULL,
Count bigINT NULL,
LengthDistribution_Id BIGINT NOT NULL
) ;
GO
CREATE TABLE dbo.DataProfiling_Join_ValueDistribution
(
ValueDistribution_Id BIGINT NOT NULL,
ColumnValueDistributionProfile_Id BIGINT NOT NULL
) ;
GO
CREATE TABLE dbo.DataProfiling_Join_LengthDistribution
(
LengthDistribution_Id BIGINT NOT NULL,
ColumnLengthDistributionProfile_Id BIGINT NOT NULL
) ;
GO