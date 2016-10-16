DECLARE @SERVER_NAME NVARCHAR(8) = @@SERVERNAME
DECLARE @DATABASE_NAME NVARCHAR(8) = DB_NAME()

------------------------------------------

IF OBJECT_ID('tempdb..#Metadata_ColumnTableType') IS NOT NULL
DROP TABLE tempdb..#Metadata_ColumnTableType;

CREATE TABLE #Metadata_ColumnTableType(
	SERVER_NAME [varchar](8) NULL,
	DATABASE_NAME [varchar](8) NULL,
	[TABLE_SCHEMA] [varchar](8) NULL,
	[TABLE_NAME] [varchar](8) NULL,
	[COLUMN_NAME] [varchar](8) NULL,
	[column_id] [int] NULL,
	[DataType] [varchar](8) NULL,
	[ColLength] [int] NULL,
	[precision] [tinyint] NULL,
	[scale] [tinyint] NULL,
	[CollationName] [varchar](8) NULL,
	[IsNullable] [bit] NULL,
	[IsIdentity] [bit] NULL,
	[IsComputed] [bit] NULL,
	[IsFileStream] [bit] NULL,
	[IsSparse] [bit] NULL,
	[IsColumnSet] [bit] NULL,
	[object_id] [int] NULL,
	[default_object_id] [int] NULL,
	[ColDefinition] [varchar](max) NULL,
	[DefaultName] [varchar](250) NULL,
	[DefaultDefinition] [varchar](max) NULL,
	[IsFulltextIndexed] [bit] NULL,
	[CalcDefinition] [varchar](4000) NULL,
	[CHARACTER_SET_NAME] [varchar](250) NULL,
	[IsPersisted] [bit] NULL,
	[IsCharCol] [int] NULL,
	[IdentitySeedValue] [int] NULL,
	[IdentityIncrementValue] [int] NULL,
	[IdentityLastValue] [bigint] NULL,
	[DateCreated] [datetime] NULL,
	[DateModified] [datetime] NULL,
	[FullTextTypeColumn] [int] NULL,
	[IsIndexable] [int] NULL,
	[IsRowGuidCol] [int] NULL,
	[IsXmlIndexable] [int] NULL,
	[UsesAnsiTrim] [int] NULL
)


INSERT INT	#Metadata_ColumnTableType
(
SERVER_NAME
,DATABASE_NAME
,TABLE_SCHEMA
,TABLE_NAME
,COLUMN_NAME
,column_id
,DataType
,ColLength
,precision
,scale
,CollationName
,IsNullable
,IsIdentity
,IsComputed
,IsFileStream
,IsSparse
,IsColumnSet
,object_id
,default_object_id
,ColDefinition
,DefaultName
,DefaultDefinition
,IsFulltextIndexed
,CalcDefinition
,CHARACTER_SET_NAME
,IsPersisted
,IsCharCol
,IdentitySeedValue
,IdentityIncrementValue
,IdentityLastValue
,DateCreated
,DateModified
,FullTextTypeColumn
,IsIndexable
,IsRowGuidCol
,IsXmlIndexable
,UsesAnsiTrim
)


SELECT DISTINCT    TOP (100) PERCENT 

@SERVER_NAME
,@DATABASE_NAME
,SCH.name AS TABLE_SCHEMA
,TBL.name AS TABLE_NAME
,COL.name AS COLUMN_NAME
,COL.column_id
,TYP.name AS DataType
,CASE
WHEN TYP.name IN ('nchar','nvarchar') THEN (COL.max_length / 2)
ELSE COL.max_length
END AS ColLength
,COL.precision
,COL.scale
,COL.collation_name AS CollationName
,COL.is_nullable AS IsNullable
,COL.is_identity AS IsIdentity
,COL.is_computed  AS IsComputed
,COL.is_filestream AS IsFileStream
,COL.is_sparse AS IsSparse
,COL.is_column_set AS IsColumnSet
,COL.object_id 
,COL.default_object_id               
,CAST('' AS VARCHAR(MAX)) AS ColDefinition
,CAST('' AS VARCHAR(250)) AS DefaultName
,CAST('' AS VARCHAR(MAX)) AS DefaultDefinition
,CAST(NULL AS BIT) AS IsFulltextIndexed    
,CAST('' AS VARCHAR(4000)) AS CalcDefinition
,CAST('' AS VARCHAR(250)) AS CHARACTER_SET_NAME
,CAST(0 AS BIT) AS IsPersisted                 
,CASE
WHEN TYP.collation_name IS NOT NULL THEN 1
ELSE 0
END AS IsCharCol
,CAST(0 AS INT) AS IdentitySeedValue
,CAST(0 AS INT) AS IdentityIncrementValue
,CAST(0 AS BIGINT) AS IdentityLastValue
,OBJ.create_date AS DateCreated
,OBJ.modify_date AS DateModified
,COLUMNPROPERTY(TBL.object_id, COL.name, 'FullTextTypeColumn') AS FullTextTypeColumn
,COLUMNPROPERTY(TBL.object_id, COL.name, 'IsIndexable') AS IsIndexable
,COLUMNPROPERTY(TBL.object_id, COL.name, 'IsRowGuidCol') AS IsRowGuidCol
,COLUMNPROPERTY(TBL.object_id, COL.name, 'IsXmlIndexable') AS IsXmlIndexable
,COLUMNPROPERTY(TBL.object_id, COL.name, 'UsesAnsiTrim') AS UsesAnsiTrim
                                          
FROM        sys.types AS TYP 
			INNER JOIN
            sys.columns AS COL ON TYP.user_type_id = COL.user_type_id 
            INNER JOIN sys.tables AS TBL
            INNER JOIN sys.schemas AS SCH 
            ON TBL.schema_id = SCH.schema_id 
            INNER JOIN sys.objects AS OBJ 
            ON TBL.object_id = OBJ.object_id 
            ON COL.object_id = TBL.object_id
            
WHERE		TBL.type_desc = 'USER_TABLE'
			AND TBL.is_ms_shipped = 0
                      
ORDER BY TABLE_SCHEMA, TABLE_NAME, COL.column_id

IF OBJECT_ID('tempdb..#Tmp_ColFileStream') IS NOT NULL
DROP TABLE tempdb..#Tmp_ColFileStream;

SELECT     
SCH.name AS TABLE_SCHEMA
,TTP.name AS TABLE_NAME
,COL.name AS COLUMN_NAME
,COL.is_filestream AS IsFileStream

INT	#Tmp_ColFileStream

FROM		sys.columns COL
			INNER JOIN sys.table_types TTP
			ON COL.object_id = TTP.type_table_object_id 
			INNER JOIN sys.schemas SCH
            ON TTP.schema_id = SCH.schema_id



IF OBJECT_ID('tempdb..#Tmp_ColCalculated') IS NOT NULL
DROP TABLE tempdb..#Tmp_ColCalculated;

SELECT     
SCH.name AS TABLE_SCHEMA
,TTP.name AS TABLE_NAME
,COL.name AS COLUMN_NAME
,COL.is_persisted AS IsPersisted
,COL.definition AS CalcDefinition

INT	#Tmp_ColCalculated

FROM        sys.table_types TTP 
			INNER JOIN sys.schemas AS SCH 
			ON TTP.schema_id = SCH.schema_id 
			INNER JOIN sys.computed_columns COL
			ON TTP.type_table_object_id = COL.object_id



-- Column Defaults

IF OBJECT_ID('tempdb..#Tmp_ColDefault') IS NOT NULL
DROP TABLE tempdb..#Tmp_ColDefault;

SELECT     
SCH.name AS TABLE_SCHEMA
,TTP.name AS TABLE_NAME
,COL.name AS COLUMN_NAME
,SDC.name AS DefaultName
,SDC.definition AS DefaultDefinition
      
INT	#Tmp_ColDefault
                
FROM		sys.default_constraints SDC
			INNER JOIN sys.columns COL
			ON SDC.parent_object_id = COL.object_id 
			AND SDC.parent_column_id = COL.column_id 
			INNER JOIN sys.table_types TTP
			ON COL.object_id = TTP.type_table_object_id 
			INNER JOIN sys.schemas SCH
			ON SCH.schema_id = TTP.schema_id


-- Identity Details

IF OBJECT_ID('tempdb..#Tmp_IdentityDetails') IS NOT NULL
DROP TABLE tempdb..#Tmp_IdentityDetails;

SELECT     
SCH.name AS TABLE_SCHEMA
,TTP.name AS TABLE_NAME
,ICL.name AS COLUMN_NAME
,ICL.column_id
,CAST(ICL.seed_value AS INT ) AS seed_value
,CAST(ICL.increment_value AS INT ) AS increment_value
,CAST(ICL.last_value AS BIGINT ) AS last_value
,ICL.object_id

INT	#Tmp_IdentityDetails
                    
FROM		sys.table_types TTP
			INNER JOIN sys.schemas SCH
			ON TTP.schema_id = SCH.schema_id 
			INNER JOIN sys.identity_columns ICL
			ON TTP.type_table_object_id = ICL.object_id

-- Update with Filestream data

UPDATE		DM

SET			DM.IsFileStream = FS.IsFileStream

FROM		#Metadata_ColumnTableType DM
			INNER JOIN #Tmp_ColFileStream FS
			ON FS.TABLE_SCHEMA = DM.TABLE_SCHEMA
			AND FS.TABLE_NAME = DM.TABLE_NAME
			AND FS.COLUMN_NAME = DM.COLUMN_NAME
			

-- Update with Calculated data

UPDATE		DM

SET			DM.CalcDefinition = CC.CalcDefinition
			,DM.IsPersisted = CC.IsPersisted

FROM		#Metadata_ColumnTableType DM
			INNER JOIN #Tmp_ColCalculated CC
			ON DM.TABLE_SCHEMA = CC.TABLE_SCHEMA
			AND DM.TABLE_NAME = CC.TABLE_NAME
			AND DM.COLUMN_NAME = CC.COLUMN_NAME
			
-- Update with Defaults

UPDATE		DM

SET			DM.DefaultDefinition = CONVERT(VARCHAR(MAX),CD.DefaultDefinition)
			,DM.DefaultName = CD.DefaultName
FROM		#Metadata_ColumnTableType DM
			INNER JOIN #Tmp_ColDefault CD
			ON DM.TABLE_SCHEMA = CD.TABLE_SCHEMA
			AND DM.TABLE_NAME = CD.TABLE_NAME
			AND DM.COLUMN_NAME = CD.COLUMN_NAME
	

-- Update FullText indicator

UPDATE		Tmp
SET			Tmp.IsFulltextIndexed = 1
FROM		#Metadata_ColumnTableType Tmp
			INNER JOIN sys.fulltext_index_columns FTI
			ON Tmp.object_id = FTI.object_id
			AND Tmp.Column_id = FTI.Column_id

-- Update Identity Details

UPDATE		DM
SET			DM.IdentitySeedValue = Tmp.seed_value
			,DM.IdentityIncrementValue = Tmp.increment_value
			,DM.IdentityLastValue = Tmp.last_value
FROM		#Metadata_ColumnTableType DM
			INNER JOIN 	#Tmp_IdentityDetails TMP
			ON DM.object_id = Tmp.object_id	
			AND DM.column_id = Tmp.column_id	

select * from #Metadata_ColumnTableType
