USE CarSales_Staging;
GO
MERGE CarSales_Staging.dbo.Client_SCD1 AS DST
USING CarSales.dbo.Client AS SRC
ON (SRC.ID = DST.BusinessKey)
WHEN NOT MATCHED THEN
INSERT (BusinessKey, ClientName, Country, Town, County, Address1, Address2, ClientType, ClientSize)
VALUES (SRC.ID, SRC.ClientName, SRC.Country, SRC.Town, SRC.County, Address1, Address2, ClientType, ClientSize)
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
THEN UPDATE
SET
DST.ClientName = SRC.ClientName
,DST.Country = SRC.Country
,DST.Town = SRC.Town
,DST.Address1 = SRC.Address1
,DST.Address2 = SRC.Address2
,DST.ClientType = SRC.ClientType
,DST.ClientSize = SRC.ClientSize
;