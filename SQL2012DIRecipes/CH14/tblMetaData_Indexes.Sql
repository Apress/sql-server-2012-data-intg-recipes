IF OBJECT_ID('dbo.MetaData_Indexes') IS NOT NULL
DROP TABLE dbo.MetaData_Indexes;
CREATE TABLE CarSales_Staging.dbo.MetaData_Indexes
(
SERVER_NAME NVARCHAR(128) NULL,
DATABASE_NAME NVARCHAR(128) NULL,
SCHEMA_NAME NVARCHAR(128) NULL,
TABLE_NAME NVARCHAR(128) NULL,
INDEX_NAME NVARCHAR(128) NULL,
name NVARCHAR(128) NULL,
index_column_id INT NULL,
key_ordinal INT NULL,
type_desc NVARCHAR(60) NULL,
is_unique BIT NULL,
ignore_dup_key BIT NULL,
is_primary_key BIT NULL,
is_unique_constraint BIT NULL,
fill_factor tinyINT NULL,
is_padded BIT NULL,
is_disabled BIT NULL,
allow_row_locks BIT NULL,
allow_page_locks BIT NULL,
has_filter BIT NULL,
filter_definition NVARCHAR(max) NULL,
is_included_column BIT NULL,
is_descending_key BIT NULL,
FileGroup NVARCHAR(128) NULL,
TableObjectID INT NULL,
IsNoRecompute BIT NULL,
IndexDepth INT NULL,
IsAutoStatistics BIT NULL,
IsClustered BIT NULL,
IsFulltextKey BIT NULL,
DataSpace NVARCHAR(128) NULL
) ;
GO