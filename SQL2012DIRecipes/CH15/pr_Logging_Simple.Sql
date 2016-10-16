CREATE PROCEDURE CarSales_Logging.log.pr_Logging_Simple
(
@Event VARCHAR(150)
,@Comments VARCHAR(MAX) = NULL
,@ErrorNo INT = NULL
,@ErrorDescription VARCHAR(MAX) = NULL
,@ErrorLineNo INT = NULL
,@ErrorSeverity INT = NULL
,@ErrorState INT = NULL
,@StartTime DATETIME
)
AS
INSERT INTO CarSales_Logging.log.EventDetail_Simple
(
Event
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
@Event
,@StartTime
,@Comments
,@ErrorNo
,@ErrorDescription
,@ErrorLineNo
,@ErrorSeverity
,@ErrorState
) ;
GO