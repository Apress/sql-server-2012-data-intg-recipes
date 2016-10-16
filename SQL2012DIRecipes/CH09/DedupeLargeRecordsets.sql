IF OBJECT_ID('TempDB..#Tmp_Client_DUPS') IS NOT NULL DROP TABLE TempDB..#Tmp_Client_DUPS;
IF OBJECT_ID('TempDB..#Tmp_Client_DUPData') IS NOT NULL DROP TABLE
TempDB..#Tmp_Client_DUPData;
-- get duplicates
SELECT ClientName,Country,Town,County,Address1,Address2,ClientType,ClientSize
INTO #Tmp_Client_DUPS
FROM CarSales_Staging.dbo.ClientWithDuplicates
GROUP BY ClientName,Country,Town,County,Address1,Address2,ClientType,ClientSize
HAVING COUNT(*) > 1;
-- get full data on deletes
SELECT
TD.ClientName,TD.Country,TD.Town,TD.County,TD.Address1,TD.Address2,
TD.ClientType,TD.ClientSize,
ROW_NUMBER() OVER (PARTITION BY
TD.ClientName,TD.Country,TD.Town,TD.County,
TD.Address1,TD.Address2,TD.ClientType,TD.ClientSize
ORDER BY TD.ClientName,TD.Country,TD.Town,TD.County,TD.Address1,TD.Address2,
TD.ClientType,TD.ClientSize DESC) AS RowNo
INTO #Tmp_Client_DUPData
FROM dbo.Client TD
INNER JOIN #Tmp_Client_DUPS DUP
ON TD.ClientName = DUP.ClientName
AND TD.Country = DUP.Country
AND TD.Town = DUP.Town
AND TD.County = DUP.County
AND TD.Address1 = DUP.Address1
AND TD.Address2 = DUP.Address2
AND TD.ClientType = DUP.ClientType
AND TD.ClientSize = DUP.ClientSize;
-- delete
DELETE C
FROM dbo.Client C
INNER JOIN #Tmp_Client_DUPData TMP
ON C.ClientName = TMP.ClientName
AND C.Country = TMP.Country
AND C.Town = TMP.Town
AND C.County = TMP.County
AND C.Address1 = TMP.Address1
AND C.Address2 = TMP.Address2
AND C.ClientType = TMP.ClientType
AND C.ClientSize = TMP.ClientSize;
-- reinsert single records
INSERT INTO dbo.Client
(
ClientName
,Country
,Town
,County
,Address1
,Address2
,ClientType
,ClientSize
)
SELECT
ClientName
,Country
,Town
,County
,Address1
,Address2
,ClientType
,ClientSize
FROM #Tmp_Client_DUPData
WHERE RowNo = 1;