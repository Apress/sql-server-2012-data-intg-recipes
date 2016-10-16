DECLARE @StartTime DATETIME
DECLARE @ProcName VARCHAR(150) -- The calling procedure
DECLARE @ProcStep VARCHAR(150) -- The step in the procedure
SET @ProcName = OBJECT_NAME(@@PROCID)
BEGIN TRY
SET @ProcStep = 'My test'
--Your code here --
END TRY
BEGIN CATCH
DECLARE @Error_Number int
DECLARE @ ErrorDescription VARCHAR(MAX)
DECLARE @ErrorLine INT
DECLARE @ErrorSeverity INT
DECLARE @ErrorState INT
DECLARE @Message VARCHAR(150)
SET @Error_Number = ERROR_NUMBER()
SET @ErrorDescription = ERROR_MESSAGE()
SET @ErrorLine = ERROR_LINE()
SET @ErrorSeverity = ERROR_SEVERITY()
SET @ErrorState = ERROR_STATE()
SET @Message = 'Error in procedure: ' + @ProcName + ' - ' + @ErrorDescription
RAISERROR(@Message ,16,1)
END CATCH