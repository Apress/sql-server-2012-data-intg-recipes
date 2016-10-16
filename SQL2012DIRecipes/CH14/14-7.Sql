SELECT TOP (100) PERCENT
sys.objects.name AS TableName
,COALESCE (sys.dm_db_missing_index_details.equality_columns
,sys.dm_db_missing_index_details.inequality_columns) AS IndexCols
,sys.dm_db_missing_index_details.included_columns
,user_seeks
,user_scans
FROM sys.dm_db_missing_index_details
INNER JOIN sys.objects
ON sys.dm_db_missing_index_details.object_id = sys.objects.object_id
INNER JOIN sys.dm_db_missing_index_groups
ON sys.dm_db_missing_index_details.index_handle =
sys.dm_db_missing_index_groups.index_handle
INNER JOIN sys.dm_db_missing_index_group_stats
ON sys.dm_db_missing_index_groups.index_group_handle =
sys.dm_db_missing_index_group_stats.group_handle
ORDER BY TableName, IndexCols ;