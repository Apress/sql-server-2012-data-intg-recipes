-- pr_AuditCounters
CREATE PROCEDURE CarSales_Logging.Log.pr_AuditCounters
AS
DECLARE @RunID INT
SELECT @RunID=MAX(RunID) FROM CarSales_Logging.log.RunHistory
INSERT INTO CarSales.Log.ProcessCounterHistory (RunID, CounterName, CounterNumber)
SELECT TOP 1000
@RunID
,CounterName
,CounterNumber
FROM CarSales_Logging.Log.ProcessCounterBaseline AS D
INNER JOIN CarSales_Logging.Log.RefBaselineProcessessAS S
ON D.CounterName = S.CounterName
WHERE D.RunID = (SELECT MAX(RunID) FROM CarSales_Logging.log.RunHistory)

-- pr_AuditEvents
CREATE PROCEDURE CarSales_Logging.Log.pr_AuditEvents
AS
DECLARE @RunID INT
SELECT @RunID=MAX(RunID) FROM CarSales_Logging.log.RunHistory
INSERT INTO CarSales_Logging.Log.ProcessHistory (RunID, StageName, StageDuration)
SELECT TOP 1000
@RunID
,StageName
,DurationInSeconds
FROM CarSales_Logging.Log.EventDetail D
INNER JOIN CarSales_Logging.Log.RefBaselineprocesses S
ON D.Step = S.StageName
WHERE D.RunID = (SELECT MAX(RunID) FROM CarSales_Logging.log.RunHistory)
-- pr_AuditTableSize
CREATE PROCEDURE CarSales_Logging.Log.pr_AuditTableSize
AS
DECLARE @RunID INT
SELECT @RunID=MAX(RunID) FROM CarSales_Logging.log.RunHistory
DELETE FROM CarSales_Logging.Log.TableSize WHERE RunID = @RunID
INSERT INTO CarSales_Logging.Log.TableSize
(TableName, SpaceUsedKB, SpaceReservedKB, Rowcounts, RunID)
SELECT DISTINCT
SO.name AS TableName
,DPS.used_page_count * 8 AS SpaceUsedKB
,DPS.reserved_page_count * 8 AS SpaceReservedKB
,DPS.row_count AS RowCounts
,@RunID
FROM CarSales.sys.dm_db_partition_stats DPS
INNER JOIN CarSales.sys.indexes SIX
ON DPS.object_id = SIX.object_id
AND DPS.index_id = SIX.index_id
INNER JOIN CarSales.sys.objects SO
ON DPS.object_id = SO.object_id
WHERE SIX.type_desc = N'CLUSTERED'
AND SO.name IN (
SELECT TableName FROM CarSales_Logging.Log.RefTables
)