USE CarSales_Staging;
GO

CREATE PROCEDURE dbo.pr_IndexesToDisable
AS
TRUNCATE TABLE dbo.IndexList;
INSERT INTO dbo.IndexList (TableName, SchemaName , IndexScript)
SELECT
,SSC.name
,SOB.name
, 'ALTER INDEX ' + SIX.name + ' ON ' + SSC.name + '.' + SOB.name + ' DISABLE'
FROM sys.indexes SIX
INNER JOIN sys.objects SOB
ON SIX.object_id = SOB.object_id
INNER JOIN sys.schemas AS SSC
ON SOB.schema_id = SSC.schema_id
WHERE SOB.is_ms_shipped = 0
AND SIX.type_desc = 'NONCLUSTERED'
AND SOB.name = 'Clients' -- Enter the table name here
ORDER BY SIX.type_desc, SOB.name, SIX.name ;
GO