CREATE PROCEDURE CarSales_Logging.log.pr_LogEvents
(
@Process VARCHAR(150)
,@Step VARCHAR(150)
,@StartTime DATETIME
,@Comments VARCHAR(MAX) = NULL
,@ErrorNo INT = NULL
,@ErrorDescription VARCHAR(MAX) = NULL
,@ErrorLineNo INT = NULL
,@ErrorSeverity INT = NULL
,@ErrorState INT = NULL
)
AS
INSERT INTO CarSales_Logging.log.EventDetail
(
Process
,Step
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
,@StartTime
,@Comments
,@ErrorNo
,@ErrorDescription
,@ErrorLineNo
,@ErrorSeverity
,@ErrorState
) ;
GO