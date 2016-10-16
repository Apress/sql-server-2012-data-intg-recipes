SELECT COUNT(*)
FROM OPENROWSET('MSDASQL', 'Driver={Microsoft Access Text Driver (*.txt, *.csv)};
DefaultDir= C:\SQL2012DIRecipes\CH10;','select * from Stock.Txt')
WHERE Model IS NULL;

SELECT
(SELECT CAST(COUNT(*) AS NUMERIC (10,3))
FROM OPENROWSET('MSDASQL', 'Driver={Microsoft Access Text Driver (*.txt, *.csv)};
DefaultDir= C:\SQL2012DIRecipes\CH10;','SELECT * FROM Stock.txt WHERE Model IS NULL'))
/
(SELECT COUNT(*)
FROM OPENROWSET('MSDASQL', 'Driver={Microsoft Access Text Driver (*.txt, *.csv)};
DefaultDir= C:\SQL2012DIRecipes\CH10;','SELECT * FROM Stock.Txt'));