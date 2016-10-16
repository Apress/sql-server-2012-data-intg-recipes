CREATE TABLE CarSales_Logging.log.EventDetail_Simple
(
EventDetailID INT IDENTITY(1,1) NOT NULL,
Event VARCHAR(150) NULL,
Comments VARCHAR(MAX) NULL,
ErrorNo INT NULL,
ErrorDescription VARCHAR(MAX) NULL,
ErrorLineNo INT NULL,
ErrorSeverity INT NULL,
ErrorState INT NULL,
StartTime DATETIME NULL,
Logtime DATETIME DEFAULT GETDATE()
) ;
GO