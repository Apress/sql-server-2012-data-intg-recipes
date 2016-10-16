CREATE PROCEDURE CarSales.Log.pr_FinaliseProcess
(
@IsProcessSuccess BIT
)
AS
DECLARE @RunID INT
SELECT @RunID = MAX(RunID) FROM BI_Logging.CarSales_Logging.log.RunHistory
DECLARE @NoteComment VARCHAR(250)
IF @IsProcessSuccess = 1
BEGIN
SET @NoteComment = 'Automated data load successfull'
END
ELSE
BEGIN
SET @NoteComment = 'Automated data load FAILED!!'
END

UPDATE CarSales_Logging.log.RunHistory
SET IsSuccess = @IsProcessSuccess
,RunEndTime = GETDATE()
,Notes = @NoteComment
WHERE RunID = @RunID
-- Truncate logs and counters over 3 months old
DELETE FROM CarSales_Logging.Log.EventDetail
WHERE DATEDIFF(dd, DateCreated, GETDATE()) > 180
DELETE FROM CarSales_Logging.Log.ProcessCounters
WHERE DATEDIFF(dd, DateCreated, GETDATE()) > 180