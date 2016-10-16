USE CarSales;
GO
BEGIN TRY
DECLARE @LAST_SYNC_VERSION BIGINT
DECLARE @CURRENT_VERSION BIGINT
SET @CURRENT_VERSION = CHANGE_TRACKING_CURRENT_VERSION()
SELECT @LAST_SYNC_VERSION = CAST(value AS BIGINT)
FROM sys.extended_properties
WHERE major_id = OBJECT_ID('dbo.Client')
AND name = N'LAST_SYNC_VERSION'
-- need test to ensure that an update will not be missing data..
DECLARE @MIN_VALID_VERSION BIGINT
SELECT @MIN_VALID_VERSION = CHANGE_TRACKING_MIN_VALID_VERSION( OBJECT_ID('dbo.Client'));
IF @LAST_SYNC_VERSION >= @MIN_VALID_VERSION
BEGIN
-- Inserts
INSERT INTO CarSales_Staging.dbo.Client_CT
( ID,ClientName,Country,Town,County, Address1,Address2, ClientType,ClientSize)
SELECT SRC.ID,ClientName,Country,Town,County,Address1,Address2, ClientType,ClientSize
FROM dbo.Client SRC
INNER JOIN CHANGETABLE(CHANGES Client, @LAST_SYNC_VERSION) AS CT
ON SRC.ID = CT.ID
WHERE CT.SYS_CHANGE_OPERATION = 'I'
-- Deletes
DELETE FROM DST
FROM CarSales_Staging.dbo.Client_CT DST
INNER JOIN CHANGETABLE(CHANGES Client, @LAST_SYNC_VERSION) AS CT
ON CT.ID = DST.ID
WHERE CT.SYS_CHANGE_OPERATION = 'D'
-- Updates
UPDATE DST
SET DST.ClientName = SRC.ClientName
,DST.Country = SRC.Country
,DST.Town = SRC.Town
,DST.County = SRC.County
,DST.Address1 = SRC.Address1
,DST.Address2 = SRC.Address2
,DST.ClientType = SRC.ClientType
,DST.ClientSize = SRC.ClientSize
FROM CarSales_Staging.dbo.Client_CT DST
INNER JOIN dbo.Client SRC
ON DST.ID = SRC.ID
INNER JOIN CHANGETABLE(CHANGES Client, @LAST_SYNC_VERSION) AS CT
ON SRC.ID = CT.ID
WHERE CT.SYS_CHANGE_OPERATION = 'U'
END
-- after an UPSERT/DELETE
EXECUTE sys.sp_updateextendedproperty
@level0type = N'SCHEMA'
,@level0name = dbo
,@level1type = N'TABLE'
,@level1name = Client
,@name = LAST_SYNC_VERSION
,@value = @CURRENT_VERSION
;
END TRY
BEGIN CATCH
-- Add your error logging here
END CATCH