USE CarSales_Staging;
GO
-- Define the dates used in validity - assume whole 24 hour cycles
DECLARE @Yesterday INT = CAST(CAST(YEAR(DATEADD(dd,-1,GETDATE())) AS CHAR(4))
+ RIGHT('0' + CAST(MONTH(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2)
+ RIGHT('0' + CAST(DAY(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2) AS INT)
DECLARE @Today INT = CAST(CAST(YEAR(GETDATE()) AS CHAR(4))
+ RIGHT('0' + CAST(MONTH(GETDATE()) AS VARCHAR(2)),2)
+ RIGHT('0' + CAST(DAY(GETDATE()) AS VARCHAR(2)),2) AS INT);
-- Drop temp table, if it exists
IF OBJECT_ID('Tempdb..#Tmp_Client') IS NOT NULL DROP TABLE #Tmp_Client;
CREATE TABLE #Tmp_Client
(
BusinessKey INT NOT NULL,
ClientName VARCHAR(150) NULL,
Country VARCHAR(50) NULL,
Town VARCHAR(50) NULL,
County VARCHAR(50) NULL,
Address1 VARCHAR(50) NULL,
Address2 VARCHAR(50) NULL,
ClientType VARCHAR(20) NULL,
ClientSize VARCHAR(10) NULL,
) ;


-- Outer insert for Type 4 records if an existing record changes, using output from MERGE into temp table
INSERT INTO #Tmp_Client (BusinessKey, ClientName, Country, Town, Address1, Address2, ClientType, ClientSize)
SELECT BusinessKey, ClientName, Country, Town, Address1, Address2, ClientType, ClientSize
FROM
(
-- Merge statement
MERGE CarSales_Staging.dbo.Client_SCD4 AS DST
USING CarSales.dbo.Client AS SRC
ON (SRC.ID = DST.BusinessKey)
WHEN NOT MATCHED THEN
INSERT (BusinessKey, ClientName, Country, Town, Address1, Address2, ClientType, ClientSize)
VALUES (SRC.ID, SRC.ClientName, SRC.Country, SRC.Town, SRC.Address1, SRC.Address2, SRC.ClientType, SRC.ClientSize)
WHEN MATCHED
AND
ISNULL(DST.ClientName,'') <> ISNULL(SRC.ClientName,'')
OR ISNULL(DST.Country,'') <> ISNULL(SRC.Country,'')
OR ISNULL(DST.Town,'') <> ISNULL(SRC.Town,'')
OR ISNULL(DST.Address1,'') <> ISNULL(SRC.Address1,'')
OR ISNULL(DST.Address2,'') <> ISNULL(SRC.Address2,'')
OR ISNULL(DST.ClientType,'') <> ISNULL(SRC.ClientType,'')
OR ISNULL(DST.ClientSize,'') <> ISNULL(SRC.ClientSize,'')
THEN UPDATE
SET
DST.ClientName = SRC.ClientName
,DST.Country = SRC.Country
,DST.Town = SRC.Town
,DST.Address1 = SRC.Address1
,DST.Address2 = SRC.Address2
,DST.ClientType = SRC.ClientType
,DST.ClientSize = SRC.ClientSize
OUTPUT DELETED.BusinessKey, DELETED.ClientName, DELETED.Country, DELETED.Town, DELETED.Address1, DELETED.Address2, DELETED.ClientType, DELETED.ClientSize, $Action AS MergeAction
) AS MRG
WHERE MRG.MergeAction = 'UPDATE'
;


-- Update history table to set final date, version number
UPDATE TP4
SET TP4.ValidFrom = @Yesterday
FROM CarSales_Staging.dbo.Client_SCD4_History TP4
INNER JOIN #Tmp_Client TMP
ON TP4.BusinessKey = TMP.BusinessKey
WHERE TP4.ValidFrom IS NULL;
-- Add latest history records to history table
INSERT INTO CarSales_Staging.dbo.Client_SCD4_History
(
BusinessKey
,ClientName
,Country
,Town
,County
,Address1
,Address2
,ClientType
,ClientSize
,ValidFrom
,HistoricalVersion
)
SELECT
BusinessKey
,ClientName
,Country
,Town
,County
,Address1
,Address2
,ClientType
,ClientSize
,@Today
,(SELECT ISNULL(MAX(HistoricalVersion),0) + 1 AS HistoricalVersion
FROM dbo.Client_SCD4_History WHERE BusinessKey = Tmp.BusinessKey)
FROM #Tmp_Client Tmp;