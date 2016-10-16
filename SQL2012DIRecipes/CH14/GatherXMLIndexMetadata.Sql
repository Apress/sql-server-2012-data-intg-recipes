INSERT INTO Metadata_XMLIndexes
(
SERVER_NAME
,DATABASE_NAME
,SCHEMA_NAME
,TABLE_NAME
,PrimaryIndexName
,XMLPrimaryIndexID
,DataSpace
,TableID
,[Allow_Page_Locks]
,[Allow_Row_Locks]
,Is_Padded
,IsPrimaryXMLIndex
,XMLColumnName
)
SELECT
@SERVER_NAME
,@DATABASE_NAME
,SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,XIN.name AS INDEX_NAME
,XIN.index_id AS IndexID
,DSP.name AS DataSpace
,TBL.object_id AS TableID
,XIN.allow_page_locks
,XIN.allow_row_locks
,XIN.is_padded
,1
,COL.name
FROM sys.tables TBL
INNER JOIN sys.xml_indexes XIN
ON TBL.object_id = XIN.object_id
INNER JOIN sys.schemas SCH
ON TBL.schema_id = SCH.schema_id
INNER JOIN sys.data_spaces DSP
ON XIN.data_space_id = DSP.data_space_id
INNER JOIN sys.index_columns SIC
ON XIN.index_id = SIC.index_id
AND XIN.object_id = SIC.object_id
INNER JOIN sys.columns COL
ON SIC.object_id = COL.object_id
AND SIC.column_id = COL.column_id
WHERE XIN.secondary_type_desc IS NULL ;
-- Secondary XML indexes
INSERT INTO #Metadata_XMLIndexes
(
SERVER_NAME
,DATABASE_NAME
,SCHEMA_NAME
,TABLE_NAME
,PrimaryIndexName
,TableID
,XMLPrimaryIndexID
,XMLSecondaryaryIndexID
,INDEX_NAME
,SecondaryTypeDescription
,DataSpace
,Allow_Page_Locks
,Allow_Row_Locks
,Is_Padded
,IsPrimaryXMLIndex
,XMLColumnName
)
SELECT
@SERVER_NAME AS SERVER_NAME
,@DATABASE_NAME AS DATABASE_NAME
,SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,SIX.name AS PrimaryIndexName
,TBL.object_id AS TableID
,SIX.index_id AS XMLPrimaryIndexID
,XIN.index_id AS XMLSecondaryaryIndexID
,XIN.name AS INDEX_NAME
,XIN.secondary_type_desc AS SecondaryTypeDescription
,DSP.name AS DataSpace
,XIN.allow_page_locks AS AllowPageLocks
,XIN.allow_row_locks AS AllowRowLocks
,XIN.is_padded AS IsPadded
,0
,COL.name
FROM sys.indexes SIX
INNER JOIN sys.tables TBL
ON SIX.object_id = TBL.object_id
INNER JOIN sys.xml_indexes XIN
ON SIX.object_id = XIN.object_id
AND SIX.index_id = XIN.using_xml_index_id
INNER JOIN sys.schemas SCH
ON TBL.schema_id = SCH.schema_id
INNER JOIN sys.data_spaces DSP
ON XIN.data_space_id = DSP.data_space_id
INNER JOIN sys.index_columns SIC
ON XIN.index_id = SIC.index_id
AND XIN.object_id = SIC.object_id
INNER JOIN sys.columns COL
ON SIC.object_id = COL.object_id
AND SIC.column_id = COL.column_id
;