ALTER PROCEDURE dbo.sp_ssis_addlogentry
@event sysname,
@computer NVARCHAR(128),
@operator NVARCHAR(128),
@source NVARCHAR(1024),
@sourceid UNIQUEIDENTIFIER,
@executionid UNIQUEIDENTIFIER,
@starttime DATETIME,
@endtime DATETIME,
@datacode int,
@databytes image,
@message NVARCHAR(2048),
@PROCESSID INT = 1 -- NOTE: The added field
AS
INSERT INTO sysssislog
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
message,
ProcessID -- NOTE: This has been added to extend the logging capability
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
@message,
@ProcessID --NOTE: This has been added to extend the logging capability
)
RETURN 0 ;
GO