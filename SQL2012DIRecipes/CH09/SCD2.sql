USE CarSales_Staging;
GO
-- Define the dates used in validity - assume whole 24 hour cycles
DECLARE @Yesterday INT = CAST(CAST(YEAR(DATEADD(dd,-1,GETDATE())) AS CHAR(4))
+ RIGHT('0' + CAST(MONTH(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2)
+ RIGHT('0' + CAST(DAY(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2) AS INT)
DECLARE @Today INT = CAST(CAST(YEAR(GETDATE()) AS CHAR(4))
+ RIGHT('0' + CAST(MONTH(GETDATE()) AS VARCHAR(2)),2)
+ RIGHT('0' + CAST(DAY(GETDATE()) AS VARCHAR(2)),2) AS INT);
-- Insert statement for the latest, newest update to an existing dimension record
INSERT INTO dbo.Client_SCD2 (BusinessKey, ClientName, Country, Town, Address1, Address2, ClientType, ClientSize, ValidFrom, IsCurrent)
SELECT ID, ClientName, Country, Town, Address1, Address2, ClientType, ClientSize,
@Today, 1
FROM
(
-- Merge statement
MERGE CarSales_Staging.dbo.Client_SCD2 AS DST
USING CarSales.dbo.Client AS SRC
ON (SRC.ID = DST.BusinessKey)
WHEN NOT MATCHED THEN
INSERT (BusinessKey, ClientName, Country, Town, County, Address1, Address2, ClientType, ClientSize, ValidFrom, IsCurrent)
VALUES (SRC.ID, SRC.ClientName, SRC.Country, SRC.Town, SRC.County, Address1, Address2, ClientType, ClientSize, @Today, 1)
WHEN MATCHED
AND (
ISNULL(DST.ClientName,'') <> ISNULL(SRC.ClientName,'')
OR ISNULL(DST.Country,'') <> ISNULL(SRC.Country,'')
OR ISNULL(DST.Town,'') <> ISNULL(SRC.Town,'')
OR ISNULL(DST.Address1,'') <> ISNULL(SRC.Address1,'')
OR ISNULL(DST.Address2,'') <> ISNULL(SRC.Address2,'')
OR ISNULL(DST.ClientType,'') <> ISNULL(SRC.ClientType,'')
OR ISNULL(DST.ClientSize,'') <> ISNULL(SRC.ClientSize,'')
)
-- Update statement for a changed dimension record, to flag as no longer active
THEN UPDATE
SET DST.IsCurrent = 0, DST.ValidTo = @Yesterday
OUTPUT SRC.ID, SRC.ClientName, SRC.Country, SRC.Town, SRC.Address1, SRC.Address2, SRC.ClientType, SRC.ClientSize, $Action AS MergeAction
) AS MRG
WHERE MRG.MergeAction = 'UPDATE'
;