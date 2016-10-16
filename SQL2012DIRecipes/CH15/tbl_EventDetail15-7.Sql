DROP TABLE CarSales_Logging.log.EventDetail
GO
CREATE TABLE CarSales_Logging.log.EventDetail(
EventDetailID INT IDENTITY(1,1) NOT NULL,
Process VARCHAR(255) NULL,
Step VARCHAR(255) NULL,
CallingProcess VARCHAR(255) NULL,
CallingStep VARCHAR(255) NULL,
Comments VARCHAR(MAX) NULL,
ErrorNo INT NULL,
ErrorDescription VARCHAR(MAX) NULL,
ErrorLineNo INT NULL,
ErrorSeverity INT NULL,
ErrorState INT NULL,
StartTime DATETIME NULL,
Logtime DATETIME NULL
)
GO