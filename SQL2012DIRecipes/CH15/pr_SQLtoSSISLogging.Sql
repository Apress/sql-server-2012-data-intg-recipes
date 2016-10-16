CREATE PROCEDURE dbo.pr_SQLtoSSISLogging
@event sysname,
@message NVARCHAR(2048),
@datacode int,
@starttime DATETIME,
@source NVARCHAR(1024),
@operator NVARCHAR(128)
AS
DECLARE @computer NVARCHAR(128)
DECLARE @sourceid UNIQUEIDENTIFIER
DECLARE @endtime DATETIME
DECLARE @executionid UNIQUEIDENTIFIER
DECLARE @databytes VARBINARY(MAX)
SET @computer = @@SERVERNAME
SELECT @operator = USER_NAME()
SET @sourceid = NEWID()
SET @endtime = GETDATE()
SET @executionid = NEWID()
SET @databytes = CONVERT(VARBINARY(MAX),'x')
INSERT INTO dbo.sysssislog
(
event,
computer,
operator,
source,
sourceid,
executionid,
starttime,
endtime,
datacode,
databytes,
message
)
VALUES
(
@event,
@computer,
@operator,
@source,
@sourceid,
@executionid,
@starttime,
@endtime,
@datacode,
@databytes,
@message
)
RETURN 0 ;
GO