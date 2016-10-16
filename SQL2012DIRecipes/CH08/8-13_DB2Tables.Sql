CREATE TABLE [dbo].[ADOSQLServerMetadataViews](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableCatalog] [varchar](0) NULL,
	[TableName] [varchar](0) NULL,
	[TableSchema] [varchar](0) NOT NULL,
	[CheckOption] [varchar](0) NULL,
	[IsUpdatable] [varchar](5) NULL
)

CREATE TABLE [dbo].[ADOSQLServerMetadataViewColumns](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ViewCatalog] [varchar](0) NULL,
	[ViewName] [varchar](0) NULL,
	[ViewSchema] [varchar](0) NOT NULL,
	[TableCatalog] [varchar](0) NULL,
	[TableName] [varchar](0) NULL,
	[TableSchema] [varchar](0) NOT NULL,
	[ColumnName] [varchar](0) NULL
) 

CREATE TABLE [dbo].[ADOSQLServerMetadataTables](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableCatalog] [varchar](0) NULL,
	[TableName] [varchar](0) NULL,
	[TableSchema] [varchar](0) NOT NULL,
	[TableType] [varchar](0) NULL
)

CREATE TABLE [dbo].[ADOSQLServerMetadataIndexes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ConstraintCatalog] [varchar](0) NULL,
	[ConstraintSchema] [varchar](0) NULL,
	[ConstraintName] [varchar](0) NULL,
	[TableCatalog] [varchar](0) NULL,
	[TableSchema] [varchar](0) NULL,
	[TableName] [varchar](0) NULL
) 

CREATE TABLE [dbo].[ADOSQLServerMetadataIndexColumns](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ConstraintCatalog] [varchar](0) NULL,
	[ConstraintSchema] [varchar](0) NULL,
	[ConstraintName] [varchar](0) NULL,
	[TableCatalog] [varchar](0) NULL,
	[TableSchema] [varchar](0) NULL,
	[TableName] [varchar](0) NULL,
	[ColumnName] [varchar](0) NULL,
	[OrdinalPosition] [varchar](0) NULL,
	[KeyType] [varchar](0) NULL,
	[IndexName] [varchar](0) NULL
)

CREATE TABLE [dbo].[ADOSQLServerMetadataColumns](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TableCatalog] [varchar](0) NULL,
	[TableName] [varchar](0) NULL,
	[TableSchema] [varchar](0) NOT NULL,
	[ColumnName] [varchar](0) NULL,
	[OrdinalPosition] [int] NULL,
	[ColumnDefault] [varchar](0) NULL,
	[IsNullable] [varchar](5) NULL,
	[DataType] [varchar](0) NULL,
	[CharacterMaximumLength] [varchar](50) NULL,
	[CharacterOctetLength] [varchar](0) NULL,
	[NumericPrecision] [varchar](0) NULL,
	[NumericPrecisionRadix] [varchar](0) NULL,
	[NumericScale] [varchar](0) NULL,
	[DateTimePresision] [varchar](0) NULL,
	[CharacterSetCatalog] [varchar](0) NULL,
	[CharacterSetSchema] [varchar](0) NULL,
	[CharacterSetName] [varchar](0) NULL,
	[CollationCatalog] [varchar](0) NULL,
	[IsFilestream] [varchar](5) NULL,
	[IsSparse] [varchar](5) NULL,
	[IsColumnSet] [varchar](5) NULL
) 
