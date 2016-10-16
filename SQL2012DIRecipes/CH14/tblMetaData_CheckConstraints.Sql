IF OBJECT_ID('dbo.MetaData_CheckConstraints') IS NOT NULL
DROP TABLE dbo.MetaData_CheckConstraints;
CREATE TABLE CarSales_Staging.dbo.MetaData_CheckConstraints
(
SCHEMA_NAME NVARCHAR (128) NOT NULL,
TABLE_NAME NVARCHAR (128) NOT NULL,
COLUMN_NAME NVARCHAR (128) NOT NULL,
CheckConstraintName NVARCHAR (128) NOT NULL,
definition NVARCHAR(max) NULL,
) ;
GO