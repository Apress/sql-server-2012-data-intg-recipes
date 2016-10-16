DECLARE @SERVER_NAME NVARCHAR(8) = @@SERVERNAME
DECLARE @DATABASE_NAME NVARCHAR(8) = DB_NAME()
------------------------------------------
IF OBJECT_ID('tempdb..#MetaData_Tables') IS NOT NULL
DROP TABLE tempdb..#MetaData_Tables;

-- Table data

CREATE TABLE #MetaData_Tables(
	[SCHEMA_NAME] [sysname] NOT NULL,
	[TABLE_NAME] [sysname] NOT NULL,
	[object_id] [int] NOT NULL,
	[TableType] [nvarchar](60) NULL,
	[DateCreated] [datetime] NOT NULL,
	[DateModified] [datetime] NOT NULL,
	[uses_ansi_nulls] [bit] NULL,
	[text_in_row_limit] [int] NULL,
	[large_value_types_out_of_row] [bit] NULL,
	[IsCDCTracked] [bit] NULL,
	[lock_escalation_desc] [nvarchar](60) NULL,
	[LobDataSpace] [sysname] NULL,
	[FilestreamDataSpace] [sysname] NULL,
	DataSpace [varchar](250) NULL,
	DataSpaceType [varchar](250) NULL,
	[NoColumns] [smallint] NULL,
	[IsHeap] [bit] NULL,
	[NoIndexes] [bit] NULL,
	[NoRows] [bigint] NULL,
	HasAfterTrigger  [bit] NULL,
	HasDeleteTrigger [bit] NULL,
	HasInsertTrigger [bit] NULL,
	HasInsteadOfTrigger [bit] NULL,
	HasUpdateTrigger [bit] NULL,
	IsAnsiNullsOn [bit] NULL,
	IsEncrypted [bit] NULL,
	IsIndexed [bit] NULL,
	IsIndexable [bit] NULL,
	IsQuotedIdentOn [bit] NULL,
	IsSystemTable [bit] NULL,
	IsUserTable [bit] NULL,
	DeleteTriggerCount SMALLINT NULL,
	FullTextBackgroundUpdateIndexOn [bit] NULL,
	FulltextCatalogId SMALLINT NULL,
	FulltextChangeTrackingOn [bit] NULL,
	FulltextKeyColumn SMALLINT NULL,
	HasActiveFulltextIndex [bit] NULL,
	HasCheckCnst [bit] NULL,
	HasClustIndex [bit] NULL,
	HasDefaultCnst [bit] NULL,
	HasForeignKey [bit] NULL,
	HasForeignRef [bit] NULL,
	HasIdentity [bit] NULL,
	HasIndex [bit] NULL,
	HasNonclustIndex [bit] NULL,
	HasPrimaryKey [bit] NULL,
	HasRowGuidCol [bit] NULL,
	HasTextImage [bit] NULL,
	HasTimestamp [bit] NULL,
	HasUniqueCnst [bit] NULL,
	HasVarDecimalStorageFormat [bit] NULL,
	InsertTriggerCount SMALLINT NULL,
	TextInRowLimit SMALLINT NULL,
	UpdateTriggerCount SMALLINT NULL,
	HasColumnSet [bit] NULL,
	DataCompression NVARCHAR(60)
) 


INSERT INT	#MetaData_Tables
(
SCHEMA_NAME
,TABLE_NAME
,object_id
,TableType 
,DateCreated
,DAteModified
,uses_ansi_nulls
,text_in_row_limit 
,large_value_types_out_of_row
,IsCDCTracked
,lock_escalation_desc
,LobDataSpace 
,FilestreamDataSpace
,DataSpace
,DataSpaceType
,NoColumns
,IsHeap
,NoIndexes
,NoRows
,HasAfterTrigger
,HasDeleteTrigger
,HasInsertTrigger
,HasInsteadOfTrigger
,HasUpdateTrigger
,IsAnsiNullsOn
,IsEncrypted
,IsIndexed
,IsIndexable
,IsQuotedIdentOn
,IsSystemTable
,IsUserTable
,DeleteTriggerCount
,FullTextBackgroundUpdateIndexOn
,FulltextCatalogId
,FulltextChangeTrackingOn
,FulltextKeyColumn
,HasActiveFulltextIndex
,HasCheckCnst
,HasClustIndex
,HasDefaultCnst
,HasForeignKey
,HasForeignRef
,HasIdentity
,HasIndex
,HasNonclustIndex
,HasPrimaryKey
,HasRowGuidCol
,HasTextImage
,HasTimestamp
,HasUniqueCnst
,HasVarDecimalStorageFormat
,InsertTriggerCount
,TextInRowLimit
,UpdateTriggerCount
,HasColumnSet
)


SELECT
SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,TBL.object_id
,TBL.type_desc AS TableType 
,TBL.create_date AS DateCreated
,TBL.modify_date AS DAteModified
,TBL.uses_ansi_nulls
,TBL.text_in_row_limit 
,TBL.large_value_types_out_of_row
,TBL.is_tracked_by_cdc AS IsCDCTracked
,TBL.lock_escalation_desc
,DSP.name AS LobDataSpace 
,DSP1.name AS FilestreamDataSpace
,CAST(NULL AS VARCHAR(250)) AS DataSpace
,CAST(NULL AS VARCHAR(250)) AS DataSpaceType
,CAST(NULL AS SMALLINT) AS NoColumns
,CAST(NULL AS BIT) AS IsHeap
,CAST(NULL AS BIT) AS NoIndexes
,CAST(NULL AS BIGINT) AS NoRows
,OBJECTPROPERTY(TBL.object_id, 'HasAfterTrigger') AS HasAfterTrigger
,OBJECTPROPERTY(TBL.object_id, 'HasDeleteTrigger') AS HasDeleteTrigger
,OBJECTPROPERTY(TBL.object_id, 'HasInsertTrigger') AS HasInsertTrigger
,OBJECTPROPERTY(TBL.object_id, 'HasInsteadOfTrigger') AS HasInsteadOfTrigger
,OBJECTPROPERTY(TBL.object_id, 'HasUpdateTrigger') AS HasUpdateTrigger
,OBJECTPROPERTY(TBL.object_id, 'IsAnsiNullsOn') AS IsAnsiNullsOn
,OBJECTPROPERTY(TBL.object_id, 'IsEncrypted') AS IsEncrypted
,OBJECTPROPERTY(TBL.object_id, 'IsIndexed') AS IsIndexed
,OBJECTPROPERTY(TBL.object_id, 'IsIndexable') AS IsIndexable
,OBJECTPROPERTY(TBL.object_id, 'IsQuotedIdentOn') AS IsQuotedIdentOn
,OBJECTPROPERTY(TBL.object_id, 'IsSystemTable') AS IsSystemTable
,OBJECTPROPERTY(TBL.object_id, 'IsUserTable') AS IsUserTable
,OBJECTPROPERTY(TBL.object_id, 'DeleteTriggerCount') AS DeleteTriggerCount
,OBJECTPROPERTY(TBL.object_id, 'FullTextBackgroundUpdateIndexOn') AS FullTextBackgroundUpdateIndexOn
,OBJECTPROPERTY(TBL.object_id, 'FulltextCatalogId') AS FulltextCatalogId
,OBJECTPROPERTY(TBL.object_id, 'FulltextChangeTrackingOn') AS FulltextChangeTrackingOn
,OBJECTPROPERTY(TBL.object_id, 'FulltextKeyColumn') AS FulltextKeyColumn
,OBJECTPROPERTY(TBL.object_id, 'HasActiveFulltextIndex') AS HasActiveFulltextIndex
,OBJECTPROPERTY(TBL.object_id, 'HasCheckCnst') AS HasCheckCnst
,OBJECTPROPERTY(TBL.object_id, 'HasClustIndex') AS HasClustIndex
,OBJECTPROPERTY(TBL.object_id, 'HasDefaultCnst') AS HasDefaultCnst
,OBJECTPROPERTY(TBL.object_id, 'HasForeignKey') AS HasForeignKey
,OBJECTPROPERTY(TBL.object_id, 'HasForeignRef') AS HasForeignRef
,OBJECTPROPERTY(TBL.object_id, 'HasIdentity') AS HasIdentity
,OBJECTPROPERTY(TBL.object_id, 'HasIndex') AS HasIndex
,OBJECTPROPERTY(TBL.object_id, 'HasNonclustIndex') AS HasNonclustIndex
,OBJECTPROPERTY(TBL.object_id, 'HasPrimaryKey') AS HasPrimaryKey
,OBJECTPROPERTY(TBL.object_id, 'HasRowGuidCol') AS HasRowGuidCol
,OBJECTPROPERTY(TBL.object_id, 'HasTextImage') AS HasTextImage
,OBJECTPROPERTY(TBL.object_id, 'HasTimestamp') AS HasTimestamp
,OBJECTPROPERTY(TBL.object_id, 'HasUniqueCnst') AS HasUniqueCnst
,OBJECTPROPERTY(TBL.object_id, 'HasVarDecimalStorageFormat') AS HasVarDecimalStorageFormat
,OBJECTPROPERTY(TBL.object_id, 'InsertTriggerCount') AS InsertTriggerCount
,OBJECTPROPERTY(TBL.object_id, 'TextInRowLimit') AS TextInRowLimit
,OBJECTPROPERTY(TBL.object_id, 'UpdateTriggerCount') AS UpdateTriggerCount
,OBJECTPROPERTY(TBL.object_id, 'HasColumnSet') AS HasColumnSet
                 
FROM        sys.schemas AS SCH
			INNER JOIN sys.tables AS TBL
			ON SCH.schema_id = TBL.schema_id 
			LEFT OUTER JOIN sys.data_spaces DSP1 
			ON TBL.filestream_data_space_id = DSP1.data_space_id 
			LEFT OUTER JOIN sys.data_spaces DSP
			ON TBL.lob_data_space_id = DSP.data_space_id
                      
WHERE		TBL.is_ms_shipped = 0


--------------------------------------------------------------------------------
-- Get all secondary elements, process later
--------------------------------------------------------------------------------

-- FileGroup

IF OBJECT_ID('tempdb..#Tmp_FileGroupDetails') IS NOT NULL
DROP TABLE tempdb..#Tmp_FileGroupDetails;

SELECT DISTINCT 

DSP.name AS DataSpace
,DSP.type_desc AS DataSpaceType
,TBL.name AS TABLE_NAME
,TBL.object_id AS TableObjectID

INT	#Tmp_FileGroupDetails

FROM        sys.data_spaces DSP
			INNER JOIN sys.indexes SIX
			ON DSP.data_space_id = SIX.data_space_id 
			INNER JOIN sys.tables TBL
			ON SIX.object_id = TBL.object_id
	
--------------------------------------------------------------------------------
-- Process all secondary elements
--------------------------------------------------------------------------------

-- FileGroup

UPDATE		D

SET			D.DataSpace = Tmp.DataSpace
			,D.DataSpaceType = Tmp.DataSpaceType

FROM		#MetaData_Tables D
			INNER JOIN #Tmp_FileGroupDetails Tmp
			ON D.object_id = Tmp.TableObjectID
		
-- Column Counts

;
WITH NoCols_CTE (SCHEMA_NAME,TABLE_NAME,object_id, NoCols)
AS
(
SELECT     TOP (100) PERCENT 
SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,COL.object_id
,COUNT(COL.column_id) AS NoCols
                      
FROM         
			sys.columns COL
			INNER JOIN sys.tables TBL
			ON COL.object_id = TBL.object_id 
			INNER JOIN sys.schemas SCH
			ON TBL.schema_id = SCH.schema_id
                      
GROUP BY	COL.object_id, TBL.name, SCH.name
)


UPDATE			D
SET				D.NoColumns = CTE.NoCols
FROM			#MetaData_Tables D
				INNER JOIN NoCols_CTE CTE
				ON D.object_id = CTE.object_id

-- Heaps

UPDATE			#MetaData_Tables

SET				IsHeap = 1

WHERE			object_id IN	(
									SELECT DISTINCT 
									TBL.object_id
									FROM        
											sys.tables TBL
											INNER JOIN sys.schemas SCH
											ON TBL.schema_id = SCH.schema_id 
											INNER JOIN sys.indexes SIX
											ON TBL.object_id = SIX.object_id
									                      
									WHERE     SIX.type_desc = N'HEAP'
								)
-- Rows

;
WITH RowCount_CTE (SCHEMA_NAME, TABLE_NAME, object_id, NoRows)
AS
(
SELECT
SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,TBL.object_id
,SSX.rows

FROM			sys.tables TBL
				INNER JOIN sys.schemas SCH
				ON TBL.schema_id = SCH.schema_id 
				INNER JOIN sys.sysindexes SSX
				ON TBL.object_id = SSX.id
)

UPDATE			D

SET				D.NoRows = CTE.NoRows

FROM			#MetaData_Tables D
				INNER JOIN RowCount_CTE CTE
				ON D.object_id = CTE.object_id

-- Indexes

;
WITH Indexes_CTE (SCHEMA_NAME, TABLE_NAME, object_id, NoIndexes)
AS
(
SELECT
SCH.name AS SCHEMA_NAME
, TBL.name AS TABLE_NAME
, TBL.object_id
, COUNT(SIX.index_id) AS NoIndexes
                      
FROM        sys.tables TBL
			INNER JOIN sys.schemas SCH
			ON TBL.schema_id = SCH.schema_id 
			INNER JOIN sys.indexes SIX
			ON TBL.object_id = SIX.object_id

GROUP BY SCH.name, TBL.name, TBL.object_id
)


UPDATE			D

SET				D.NoIndexes = CTE.NoIndexes

FROM			#MetaData_Tables D
				INNER JOIN Indexes_CTE CTE
				ON D.object_id = CTE.object_id

-- Compression
;
WITH Compression_CTE 
AS
(
SELECT     
SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,PRT.data_compression_desc
,TBL.object_id

FROM        sys.partitions PRT
			INNER JOIN sys.tables TBL
			ON PRT.object_id = TBL.object_id 
			INNER JOIN sys.schemas SCH
			ON TBL.schema_id = SCH.schema_id
			
WHERE		PRT.index_id = 0 
			OR PRT.index_id = 1
)

UPDATE			D

SET				D.DataCompression = CTE.data_compression_desc

FROM			#MetaData_Tables D
				INNER JOIN Compression_CTE CTE
				ON D.object_id = CTE.object_id


select * from #MetaData_Tables
