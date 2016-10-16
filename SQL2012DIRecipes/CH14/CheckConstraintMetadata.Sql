INSERT INTO MetaData_CheckConstraints
(
SCHEMA_NAME
,TABLE_NAME
,COLUMN_NAME
,CheckConstraintName
,definition
)
SELECT
SCH.name AS SCHEMA_NAME
,TBL.name AS TABLE_NAME
,COL.name
,CHK.name AS CheckConstraintName
,CHK.definition
FROM sys.schemas AS SCH
INNER JOIN sys.tables AS TBL
ON SCH.schema_id = TBL.schema_id
INNER JOIN sys.check_constraints CHK
ON TBL.object_id = CHK.parent_object_id
INNER JOIN sys.columns COL
ON CHK.parent_object_id = COL.object_id
AND CHK.parent_column_id = COL.column_id
WHERE CHK.is_disabled = 0 ;