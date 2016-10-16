DECLARE @Cost_Price INT
DECLARE @Registration_Year INT
DECLARE @ROWCOUNT INT
DECLARE @Mileage_MAX INT
DECLARE @Mileage_MIN INT
DECLARE @Registration_Year_NULL INT
DECLARE @Cost_Price_NULL INT
SELECT
CASE
WHEN Registration_Year IS NULL THEN 1 ELSE 0
END AS Registration_Year
,CASE
WHEN Cost_Price IS NULL THEN 1 ELSE 0
END AS Cost_Price
INTO #NullSourceRecords
FROM OPENROWSET('MSDASQL', 'Driver={Microsoft Access Text Driver (*.txt, *.csv)};
DefaultDir= C:\SQL2012DIRecipes\CH10;','select Registration_Year, Cost_Price from Stock.txt')
WHERE Registration_Year IS NULL OR Cost_Price IS NULL
SELECT
@ROWCOUNT = COUNT(*)
,@Mileage_MAX = MAX(Mileage)
,@Mileage_MIN = MIN(Mileage)
FROM OPENROWSET('MSDASQL', 'Driver={Microsoft Access Text Driver (*.txt, *.csv)};
DefaultDir= C:\SQL2012DIRecipes\CH10;','select Registration_Year, Cost_Price from Stock.txt')
SELECT
@Registration_Year_NULL = SUM(Registration_Year)
,@Cost_Price_NULL = SUM(Cost_Price)
FROM #NullSourceRecords
PRINT @ROWCOUNT
PRINT @Mileage_MAX
PRINT @Mileage_MIN
PRINT @Registration_Year_NULL
PRINT @Cost_Price_NULL
PRINT CAST(@Registration_Year_NULL AS NUMERIC (12,6))
/ CAST(@ROWCOUNT AS NUMERIC (12,6))