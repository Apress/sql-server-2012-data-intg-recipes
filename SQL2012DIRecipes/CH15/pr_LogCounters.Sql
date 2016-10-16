CREATE PROCEDURE CarSales_Logging.log.pr_LogCounters
(
@CounterType NVARCHAR(250)
,@CounterDescription NVARCHAR(250)
,@CounterResult BIGINT
,@ProcessName NVARCHAR(150) = NULL
,@ProcessStep NVARCHAR(150) = NULL
,@UserName NVARCHAR(150) = NULL
,@ComputerName NVARCHAR(150) = NULL
)
AS
DECLARE @PROCESSID INT
SELECT @PROCESSID = MAX(ID) FROM dbo.ProcessHistory
INSERT INTO dbo.Log_ProcessCounters
(
ProcessID
,CounterType
,CounterDescription
,CounterResult
,ProcessName
,ProcessStep
,UserName
,ComputerName
)
VALUES
(
@PROCESSID
,@CounterType
,@CounterDescription
,@CounterResult
,@ProcessName
,@ProcessStep
,@UserName
,@ComputerName
)