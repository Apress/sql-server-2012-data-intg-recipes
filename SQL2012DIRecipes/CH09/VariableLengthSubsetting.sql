SELECT
ID
,CASE -- First Column or entire column, any number of columns
WHEN LEN(ClientDataVariable) - LEN(REPLACE(ClientDataVariable, '-', '')) <> 0 THEN LEFT(ClientDataVariable, CHARINDEX('-',ClientDataVariable) - 1)
WHEN LEN(ClientDataVariable) - LEN(REPLACE(ClientDataVariable, '-', '')) = 0 THEN ClientDataVariable
END AS ColLeft
,CASE -- Three or Four columns, second column
WHEN LEN(ClientDataVariable) - LEN(REPLACE(ClientDataVariable, '-', '')) = 3
THEN LEFT(SUBSTRING(ClientDataVariable, CHARINDEX('-',ClientDataVariable) + 1,
LEN(ClientDataVariable) - CHARINDEX('-',ClientDataVariable)
- CHARINDEX('-',REVERSE(ClientDataVariable))), CHARINDEX('-',SUBSTRING(ClientDataVariable
, CHARINDEX('-',ClientDataVariable) + 1, LEN(ClientDataVariable)
- CHARINDEX('-',ClientDataVariable) - CHARINDEX('-',REVERSE(ClientDataVariable)))) -1)
WHEN LEN(ClientDataVariable) - LEN(REPLACE(ClientDataVariable, '-', '')) = 2
THEN SUBSTRING(ClientDataVariable, CHARINDEX('-',ClientDataVariable) + 1
, CHARINDEX('-',ClientDataVariable, CHARINDEX('-',ClientDataVariable) + 1)
- CHARINDEX('-',ClientDataVariable) - 1)
END AS Col2
,CASE -- Four columns, third column
WHEN LEN(ClientDataVariable) - LEN(REPLACE(ClientDataVariable, '-', '')) = 3
THEN RIGHT(SUBSTRING(ClientDataVariable, CHARINDEX('-',ClientDataVariable) + 1,
LEN(ClientDataVariable) - CHARINDEX('-',ClientDataVariable)
- CHARINDEX('-',REVERSE(ClientDataVariable)))
, CHARINDEX('-',SUBSTRING(REVERSE(ClientDataVariable), CHARINDEX('-',ClientDataVariable)
+ 1, LEN(ClientDataVariable) - CHARINDEX('-',ClientDataVariable)
- CHARINDEX('-',REVERSE(ClientDataVariable)))) -1)
END AS Col3
,CASE -- Last column, any number of columns
WHEN (LEN(ClientDataVariable) - LEN(REPLACE(ClientDataVariable, '-', ''))) <> 0
THEN REVERSE(LEFT(REVERSE(ClientDataVariable), CHARINDEX('-',REVERSE(ClientDataVariable)) - 1))
END AS ColRight;
FROM dbo.ClientSubset