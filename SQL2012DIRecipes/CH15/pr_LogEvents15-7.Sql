DROP PROCEDURE CarSales_Logging.log.pr_LogEvents
GO
CREATE PROCEDURE CarSales_Logging.log.pr_LogEvents
(
@Process VARCHAR(150)
,@Step VARCHAR(150)
,@CallingProcess VARCHAR(150)
,@CallingStep VARCHAR(150)
,@StartTime DATETIME
,@Comments VARCHAR(MAX) = NULL
,@ErrorNo INT = NULL
,@ErrorDescription VARCHAR(MAX) = NULL
,@ErrorLineNo INT = NULL
,@ErrorSeverity INT = NULL
,@ErrorState INT = NULL
)
AS
INSERT INTO EventDetail
(
Process
,Step
,CallingProcess
,CallingStep
,StartTime
,Comments
,ErrorNo
,ErrorDescription
,ErrorLineNo
,ErrorSeverity
,ErrorState
)
VALUES
(
@Process
,@Step
,@CallingProcess
,@CallingStep
,@StartTime
,@Comments
,@ErrorNo
,@ErrorDescription
,@ErrorLineNo
,@ErrorSeverity
,@ErrorState
)