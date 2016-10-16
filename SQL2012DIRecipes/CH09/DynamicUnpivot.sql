DECLARE @ColList VARCHAR(8000) = '';
DECLARE @SQLCode VARCHAR(8000) = '';
DECLARE @ColFilter VARCHAR(1000) = 'contact';
DECLARE @KeyCol VARCHAR(1000) = 'ID';
DECLARE @TableName VARCHAR(1000) = 'ClientList';
SELECT @ColList = @ColList + QUOTENAME(COLUMN_NAME) + ','
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = @TableName
AND COLUMN_NAME LIKE '%' + @ColFilter + '%';
IF LEN(@ColList) > 1
BEGIN
SET @ColList = LEFT(@ColList, LEN(@ColList) -1 )
SET @SQLCode =
'
SELECT ' + @KeyCol + ', ContactType, UPV.' + @ColFilter + '
FROM ' + @TableName + '
UNPIVOT (' + @ColFilter + ' FOR ContactType in (' + @ColList + ')) as UPV
';
EXECUTE CarSales_Staging.dbo.sp_executesql @statement = @SQLCode;
END
ELSE
PRINT 'No Matching columns';