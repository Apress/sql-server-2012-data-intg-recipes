DECLARE @InitialLSN BINARY(10)
DECLARE @FinalLSN BINARY(10)
DECLARE @TmpLSN BINARY(10)
DECLARE @NbInserts INT = 0
DECLARE @NbUpdates INT = 0
DECLARE @NbDeletes INT = 0
-- Get the highest LSN
SELECT @FinalLSN = sys.fn_cdc_get_max_lsn()
SELECT @TmpLSN = FinalLSN
FROM dbo.CDCLSN
WHERE TableName = 'dbo_Clients'
AND ID = (SELECT MAX(ID) FROM dbo.CDCLSN WHERE TableName ='dbo_Clients')
-- Get the lowest LSN which will be used and test for changes
IF @FinalLSN = @TmpLSN
RETURN
SELECT @InitialLSN = ISNULL(@TmpLSN,sys.fn_cdc_get_min_lsn('dbo_Clients'))
-- deletes (1=delete), need PK only
DELETE FROM dbo.Clients_New
WHERE CustomerNumber IN (
SELECT CustomerNumber
FROM cdc.fn_cdc_get_net_changes_dbo_Clients(
@InitialLSN, @FinalLSN, 'all')
WHERE __$operation = 1
)
SET @NbDeletes = @@ROWCOUNT
-- updates (4=value after update), need field list
UPDATE D
SET D.CustomerName = S.CustomerName
FROM dbo.Clients_New D
INNER JOIN (SELECT CustomerID,CustomerName
FROM cdc.fn_cdc_get_net_changes_dbo_Clients( @InitialLSN, @FinalLSN, 'all')
WHERE __$operation = 4) S
ON S.CustomerID = D.CustomerID
SET @NbUpdates = @@ROWCOUNT
-- Inserts (2=Insert), need field list
INSERT INTO dbo.Clients_New (CustomerID,CustomerName)
SELECT CustomerID,CustomerName
FROM cdc.fn_cdc_get_net_changes_dbo_Clients ( @InitialLSN,
@FinalLSN, 'all')
WHERE __$operation = 2
SET @NbInserts = @@ROWCOUNT
-- once all operations complete, add new highest LSN to history table for next run
INSERT INTO dbo.CDCLSN (FinalLSN,TableName, NbInserts, NbUpdates, NbDeletes)
VALUES (@FinalLSN,'dbo_Clients', @NbInserts, @NbUpdates, @NbDeletes);