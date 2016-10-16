DECLARE @LAST_SYNC_VERSION BIGINT
DECLARE @CURRENT_VERSION BIGINT
DECLARE @MIN_VALID_VERSION BIGINT
-- To get the LAST_SYNC_VERSION
SELECT @LAST_SYNC_VERSION = CAST(SEP.value AS BIGINT)
FROM R2.CarSales.sys.tables TBL
INNER JOIN R2.CarSales.sys.schemas SCH
ON TBL.schema_id = SCH.schema_id
INNER JOIN R2.CarSales.sys.extended_properties SEP
ON TBL.object_id = SEP.major_id
WHERE SCH.name = 'dbo'
AND TBL.name = 'client'
AND SEP.name = 'LAST_SYNC_VERSION'
-- Gets maximum version in CHANGETABLE - so available for updating (use instead of
CHANGE_TRACKING_CURRENT_VERSION)
SELECT @CURRENT_VERSION = MaxValidVersion FROM OPENQUERY(R2,
'
SELECT
CASE WHEN MAX(SYS_CHANGE_CREATION_VERSION) > MAX(SYS_CHANGE_VERSION) THEN MAX(SYS_CHANGE_CREATION_VERSION)
ELSE MAX(SYS_CHANGE_VERSION)
END AS MaxValidVersion
FROM CHANGETABLE(CHANGES Carsales.dbo.Client, 0) AS CT
')
-- Gets minimum version This one works over a linked server!
SELECT Min_Valid_Version FROM R2.CarSales.sys.change_tracking_tables
IF @LAST_SYNC_VERSION >= @MIN_VALID_VERSION
BEGIN
-- Get all data for INSERTS/UPDATES/DELETES into temp tables
-- Deletes
DECLARE @DeleteSQL VARCHAR(8000) =
'SELECT ID
FROM OPENQUERY(R2, ''SELECT ID
FROM CHANGETABLE(CHANGES Carsales.dbo.Client,' + CAST(@LAST_SYNC_VERSION AS VARCHAR(20)) + ')
AS CT
WHERE CT.SYS_CHANGE_OPERATION = ''''D'''''')'
IF OBJECT_ID('tempdb..#ClientDeletes') IS NOT NULL
DROP TABLE tempdb..#ClientDeletes
CREATE TABLE #ClientDeletes (ID INT)
INSERT INTO #ClientDeletes EXEC (@DeleteSQL)
-- Inserts
DECLARE @InsertsSQL VARCHAR(8000) =
'SELECT ID,ClientName,Country,Town,County,Address1,Address2,ClientType,ClientSize
FROM OPENQUERY(R2,
''SELECT SRC.ID,ClientName,Country,Town,County,Address1,Address2,
ClientType,ClientSize
FROM Carsales.dbo.Client SRC
INNER JOIN CHANGETABLE(
CHANGES Carsales.dbo.Client, ' +
CAST(@LAST_SYNC_VERSION
AS VARCHAR(20)) + ') AS CT
ON SRC.ID = CT.ID
WHERE CT.SYS_CHANGE_OPERATION = ''''I'''''')'
IF OBJECT_ID('tempdb..#ClientInserts') IS NOT NULL DROP TABLE tempdb..#ClientInserts
CREATE TABLE #ClientInserts
(
ID INT NOT NULL,
ClientName VARCHAR(150) NULL,
Country VARCHAR(50) NULL,
Town VARCHAR(50) NULL,
County VARCHAR(50) NULL,
Address1 VARCHAR(50) NULL,
Address2 VARCHAR(50) NULL,
ClientType VARCHAR(20) NULL,
ClientSize VARCHAR(10) NULL
)
INSERT INTO #ClientInserts EXEC (@InsertsSQL)
-- Updates
DECLARE @UpdatesSQL VARCHAR(8000) =
'SELECT ID,ClientName,Country,Town,County,Address1,Address2,
ClientType,ClientSize
FROM OPENQUERY(R2, ''SELECT SRC.ID,ClientName,Country,Town,
County,Address1,Address2,
ClientType,ClientSize
FROM Carsales.dbo.Client SRC
INNER JOIN CHANGETABLE(CHANGES
Carsales.dbo.Client,'
+ CAST(@LAST_SYNC_VERSION AS VARCHAR(20))
+ ') AS CT
ON SRC.ID = CT.ID
WHERE CT.SYS_CHANGE_OPERATION = ''''U'''''')' ;
IF OBJECT_ID('tempdb..#ClientUpdates') IS NOT NULL DROP TABLE tempdb..#ClientUpdates;
CREATE TABLE #ClientUpdates
(
ID INT NOT NULL,
ClientName VARCHAR(150) NULL,
Country VARCHAR(50) NULL,
Town VARCHAR(50) NULL,
County VARCHAR(50) NULL,
Address1 VARCHAR(50) NULL,
Address2 VARCHAR(50) NULL,
ClientType VARCHAR(20) NULL,
ClientSize VARCHAR(10) NULL
) ;
INSERT INTO #ClientUpdates
(ID,ClientName,Country,Town,County,Address1,Address2,ClientType,ClientSize) EXEC (@UpdatesSQL) ;
-- Carry out INSERTS/UPDATES/DELETES
-- Inserts
INSERT INTO CarSales_Staging.dbo.Client
(ID, ClientName, Country, Town, County, Address1, Address2,
ClientType, ClientSize)
SELECT ID, ClientName, Country,Town, County, Address1, Address2,
ClientType, ClientSize
FROM #ClientInserts
-- Updates
UPDATE DST
SET DST.ClientName = UPD.ClientName
,DST.Country = UPD.Country
,DST.Town = UPD.Town
,DST.County = UPD.County
,DST.Address1 = UPD.Address1
,DST.Address2 = UPD.Address2
,DST.ClientType = UPD.ClientType
,DST.ClientSize = UPD.ClientSize
FROM CarSales_Staging.dbo.Client DST
INNER JOIN #ClientUpdates UPD
ON DST.ID = UPD.ID
-- Deletes
DELETE FROM DST
FROM CarSales_Staging.dbo.Client DST
INNER JOIN #ClientDeletes DLT
ONDLT.ID = DST.ID
-- To set the new LAST_SYNC_VERSION
EXEC R2.CarSales.sys.sp_updateextendedproperty
@level0type = N'SCHEMA'
,@level0name = dbo
,@level1type = N'TABLE'
,@level1name = Client
,@name = LAST_SYNC_VERSION
,@value = @CURRENT_VERSION
;
END