CREATE TABLE dbo.ADOSQLServerMetadataViews
(
ID INT IDENTITY(1,1) NOT NULL,
TableCatalog VARCHAR(50) NULL,
TableName VARCHAR(50) NULL,
TableSchema VARCHAR(50) NOT NULL,
CheckOption VARCHAR(50) NULL,
IsUpdatable VARCHAR(5) NULL
);
CREATE TABLE dbo.ADOSQLServerMetadataViewColumns
(
ID INT IDENTITY(1,1) NOT NULL,
ViewCatalog VARCHAR(50) NULL,
ViewName VARCHAR(50) NULL,
ViewSchema VARCHAR(50) NOT NULL,
TableCatalog VARCHAR(50) NULL,
TableName VARCHAR(50) NULL,
TableSchema VARCHAR(50) NOT NULL,
ColumnName VARCHAR(50) NULL
) ;
CREATE TABLE dbo.ADOSQLServerMetadataTables
(
ID INT IDENTITY(1,1) NOT NULL,
TableCatalog VARCHAR(50) NULL,
TableName VARCHAR(50) NULL,
TableSchema VARCHAR(50) NOT NULL,
TableType VARCHAR(50) NULL
);
CREATE TABLE dbo.ADOSQLServerMetadataIndexes
(
ID INT IDENTITY(1,1) NOT NULL,
ConstraintCatalog VARCHAR(50) NULL,
ConstraintSchema VARCHAR(50) NULL,
ConstraintName VARCHAR(50) NULL,
TableCatalog VARCHAR(50) NULL,
TableSchema VARCHAR(50) NULL,
TableName VARCHAR(50) NULL
) ;
CREATE TABLE dbo.ADOSQLServerMetadataIndexColumns
(
ID INT IDENTITY(1,1) NOT NULL,
ConstraintCatalog VARCHAR(50) NULL,
ConstraintSchema VARCHAR(50) NULL,
ConstraintName VARCHAR(50) NULL,
TableCatalog VARCHAR(50) NULL,
TableSchema VARCHAR(50) NULL,
TableName VARCHAR(50) NULL,
ColumnName VARCHAR(50) NULL,
OrdinalPosition VARCHAR(50) NULL,
KeyType VARCHAR(50) NULL,
IndexName VARCHAR(50) NULL
);
CREATE TABLE dbo.ADOSQLServerMetadataColumns
(
ID INT IDENTITY(1,1) NOT NULL,
TableCatalog VARCHAR(50) NULL,
TableName VARCHAR(50) NULL,
TableSchema VARCHAR(50) NOT NULL,
ColumnName VARCHAR(50) NULL,
OrdinalPosition INT NULL,
ColumnDefault VARCHAR(50) NULL,
IsNullable VARCHAR(5) NULL,
DataType VARCHAR(50) NULL,
CharacterMaximumLength VARCHAR(50) NULL,
CharacterOctetLength VARCHAR(50) NULL,
NumericPrecision VARCHAR(50) NULL,
NumericPrecisionRadix VARCHAR(50) NULL,
NumericScale VARCHAR(50) NULL,
DateTimePresision VARCHAR(50) NULL,
CharacterSetCatalog VARCHAR(50) NULL,
CharacterSetSchema VARCHAR(50) NULL,
CharacterSetName VARCHAR(50) NULL,
CollationCatalog VARCHAR(50) NULL,
IsFilestream VARCHAR(5) NULL,
IsSparse VARCHAR(5) NULL,
IsColumnSet VARCHAR(5) NULL
) ;