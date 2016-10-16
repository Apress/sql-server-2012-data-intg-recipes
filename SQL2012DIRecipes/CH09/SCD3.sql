USE CarSales_Staging;
GO
DECLARE @Yesterday INT = CAST(CAST(YEAR(DATEADD(dd,-1,GETDATE())) AS CHAR(4))
+ RIGHT('0' + CAST(MONTH(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2) + RIGHT('0'
+ CAST(DAY(DATEADD(dd,-1,GETDATE())) AS VARCHAR(2)),2) AS INT)
MERGE CarSales_Staging.dbo.Client_SCD3 AS DST
USING CarSales.dbo.Client AS SRC
ON (SRC.ID = DST.BusinessKey)
WHEN NOT MATCHED THEN
INSERT (BusinessKey, ClientName, Country)
VALUES (SRC.ID, SRC.ClientName, SRC.Country)
WHEN MATCHED
AND (DST.Country <> SRC.Country
OR DST.ClientName <> SRC.ClientName)
THEN UPDATE
SET DST.Country = SRC.Country
,DST.ClientName = SRC.ClientName
,DST.Country_Prev1 = DST.Country
,DST.Country_Prev1_ValidTo = @Yesterday
,DST.Country_Prev2 = DST.Country_Prev1
,DST.Country_Prev2_ValidTo = DST.Country_Prev1_ValidTo
;