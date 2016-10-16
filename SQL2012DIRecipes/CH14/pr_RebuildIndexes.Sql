USE CarSales_Staging;
GO
CREATE PROCEDURE dbo.pr_RebuildIndexes
AS
DECLARE @TableName NVARCHAR(128), @SchemaName NVARCHAR(128), @RebuildIndex NVARCHAR(4000)
DECLARE RebuildIndex_CUR CURSOR
FOR
SELECT DISTINCT TableName, SchemaName FROM dbo.IndexList
OPEN RebuildIndex_CUR
FETCH NEXT FROM RebuildIndex_CUR INTO @TableName, @SchemaName
WHILE @@FETCH_STATUS <> -1
BEGIN
SET @RebuildIndex = 'ALTER INDEX ALL ON ' + @SchemaName + '.' + @TableName + ' REBUILD'
EXEC (@RebuildIndex)
FETCH NEXT FROM RebuildIndex_CUR INTO @TableName, @SchemaName
END;
CLOSE RebuildIndex_CUR;
DEALLOCATE RebuildIndex_CUR;