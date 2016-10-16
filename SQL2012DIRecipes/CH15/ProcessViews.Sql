CREATE VIEW CarSales_Logging.Log.vw_LatestEvents
AS
SELECT EventDetailID, Process, Step, Comments, ErrorNo, ErrorDescription
FROM CarSales_Logging.Log.EventDetail
WHERE RunID = (SELECT MAX(RunID) AS RunID
FROM CarSales_Logging.log.RunHistory)
GO


CREATE VIEW CarSales_Logging.Log.vw_LatestErrorEvents
AS
SELECT EventDetailID, Process, Step, Comments, ErrorNo, ErrorDescription
FROM CarSales_Logging.Log.EventDetail
WHERE RunID = (SELECT MAX(RunID) AS RunID
FROM CarSales_Logging.log.RunHistory)
AND (ErrorNo IS NOT NULL
OR ErrorDescription IS NOT NULL
OR ErrorSeverity IS NOT NULL)
GO