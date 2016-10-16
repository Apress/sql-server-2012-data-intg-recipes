-- Start Header -------------------------------------------------------------
DECLARE @StartTime DATETIME
DECLARE @ ProcName VARCHAR(150) --- The calling procedure
DECLARE @ProcStep VARCHAR(150) -- The step in the procedure
SET @ProcName = OBJECT_NAME(@@PROCID)
BEGIN TRY
---- End Header ------------------------------------------------------------
SET @ProcStep = 'My test'
--Your code here --


EXECUTE CarSales_Logging.log.pr_Logging_Simple @ProcName, @ProcStep, @StartTime, 'Part of the process OK'
-- Start Footer ------------------------------------------------
END TRY
BEGIN CATCH
IF @@trancount > 0 ROLLBACK TRAN
SET XACT_ABORT OFF;
DECLARE @Error_Number int
DECLARE @ ErrorDescription VARCHAR(MAX)
DECLARE @ErrorLine INT
DECLARE @ErrorSeverity INT
DECLARE @ErrorState INT
DECLARE @Message VARCHAR(150)
SET @ERROR_NUMBER = ERROR_NUMBER()
SET @ErrorDescription = ERROR_MESSAGE()
SET @ErrorLine = ERROR_LINE()
SET @ErrorSeverity = ERROR_SEVERITY()
SET @ErrorState = ERROR_STATE()
EXECUTE CarSales_Logging.log.pr_Logging_Simple @ProcName, @ProcStep, @StartTime, 'Error - Stored Procedure', @ERROR_NUMBER, @ErrorDescription, @ErrorLineNo,
@ErrorSeverity, @ErrorState
SET @Message = 'Error in procedure: ' + @ProcName
RAISERROR(@Message ,16,1)
END CATCH
-- End footer -------------------------------------------