DECLARE @SERVER_NAME NVARCHAR(128) = @@SERVERNAME
DECLARE @DATABASE_NAME NVARCHAR(128) = DB_NAME()
INSERT INTO MetaData_Indexes
(
SERVER_NAME
,DATABASE_NAME
,SCHEMA_NAME
,TABLE_NAME
,INDEX_NAME
,name
,index_column_id
,key_ordinal
,type_desc
,is_unique
,ignore_dup_key
,is_primary_key
,is_unique_constraint
,fill_factor
,is_padded
,is_disabled
,allow_row_locks
,allow_page_locks
,has_filter
,filter_definition
,is_included_column
,is_descending_key
,FileGroup
,TableObjectID
,IsNoRecompute
,IndexDepth
,IsAutoStatistics
,IsClustered
,IsFulltextKey
,DataSpace
)
SELECT DISTINCT TOP (100) PERCENT
@SERVER_NAME
,@DATABASE_NAME
,SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,SIX.name AS INDEX_NAME
,COL.name
,SIC.index_column_id
,SIC.key_ordinal
,SIX.type_desc
,SIX.is_unique
,SIX.ignore_dup_key
,SIX.is_primary_key
,SIX.is_unique_constraint
,SIX.fill_factor
,SIX.is_padded
,SIX.is_disabled
,SIX.allow_row_locks
,SIX.allow_page_locks
,SIX.has_filter
,SIX.filter_definition
,SIC.is_included_column
,SIC.is_descending_key
,CAST(NULL AS VARCHAR(128))
,TBL.object_id
,CAST(NULL AS BIT)
,INDEXPROPERTY(TBL.object_id, SIX.name,'IndexDepth') AS IndexDepth
,INDEXPROPERTY(TBL.object_id, SIX.name,'IsAutoStatistics') AS IsAutoStatistics
,INDEXPROPERTY(TBL.object_id, SIX.name,'IsClustered') AS IsClustered
,INDEXPROPERTY(TBL.object_id, SIX.name,'IsFulltextKey') AS IsFulltextKey
,DSP.name AS DataSpace
FROM sys.data_spaces DSP
INNER JOIN sys.indexes SIX
ON DSP.data_space_id = SIX.data_space_id
INNER JOIN sys.tables TBL
ON SIX.object_id = TBL.object_id
INNER JOIN sys.schemas SCH
ON TBL.schema_id = SCH.schema_id
INNER JOIN sys.index_columns SIC
ON SIX.index_id = SIC.index_id
AND SIX.object_id = SIC.object_id
INNER JOIN sys.columns COL
ON SIC.column_id = COL.column_id
AND TBL.object_id = COL.object_id
LEFT OUTER JOIN sys.xml_indexes XMI
ON SIX.name = XMI.name
AND SIX.object_id = XMI.object_id
WHERE TBL.is_ms_shipped = 0
AND XMI.name IS NULL
ORDER BY SCHEMA_NAME, TABLE_NAME, INDEX_NAME, SIC.key_ordinal
-- Add FileGroup, NoRecompute, note that online & drop existing are not stored in metadata
IF OBJECT_ID('tempdb..#Tmp_IndexFileGroups') IS NOT NULL
DROP TABLE tempdb..#Tmp_IndexFileGroups;
SELECT DISTINCT
DSP.name AS DataSpace
,TBL.name AS TABLE_NAME
,TBL.object_id AS TableObjectID
,SIX.name
,SIX.type_desc
,STT.no_recompute
INTO #Tmp_IndexFileGroups
FROM sys.data_spaces DSP
INNER JOIN sys.indexes SIX
ON DSP.data_space_id = SIX.data_space_id
INNER JOIN sys.tables TBL
ON SIX.object_id = TBL.object_id
INNER JOIN sys.stats STT
ON STT.object_id = TBL.object_id
AND STT.name = SIX.name
WHERE SIX.name IS NOT NULL
-- Update Filegroup
UPDATE D
SET D.FileGroup = Tmp.DataSpace
,D.IsNoRecompute = TMP.no_recompute
FROM MetaData_Indexes D
INNER JOIN #Tmp_IndexFileGroups TMP
ON D.TableObjectID = Tmp.TableObjectID