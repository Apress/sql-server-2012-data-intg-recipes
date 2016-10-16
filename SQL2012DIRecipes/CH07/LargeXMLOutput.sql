-- Instantiate temp table of sequential IDS mapping to unique keys in data source
IF OBJECT_ID('Tempdb..#IDSet') IS NOT NULL DROP TABLE #IDSet;
SELECT ID, ROW_NUMBER() OVER (ORDER BY ID) AS ROWNO
INTO #IDSet
FROM dbo.Client;
-- Create temp table to hold XML output and ordering info
IF OBJECT_ID('dbo.XMLOutput') IS NOT NULL DROP TABLE XMLOutput;
CREATE TABLE XMLOutput (XMLCol NVARCHAR(MAX), SortID INT);
-- Iteration variables
DECLARE @LowerThreshold INT = 0
DECLARE @UpperThreshold INT
DECLARE @Range INT = 20000
SELECT @UpperThreshold = MAX(ROWNO) FROM #IDSet;
-- Add root element
INSERT INTO XMLOutput (XMLCol, SortID)
VALUES (' <Root> ', 0);
-- Loop through data and output XML
WHILE @LowerThreshold <= @UpperThreshold
BEGIN
INSERT INTO XMLOutput (XMLCol, SortID)
SELECT A.ClientXML, @LowerThreshold
FROM
(
SELECT C.ID, ClientName, Country, Town
FROM CarSales.dbo.Client C
INNER JOIN #IDSet S
ON C.ID = S.ID
WHERE ROWNO > @LowerThreshold AND ROWNO <= @LowerThreshold + @Range
FOR XML PATH('Client')
) A (ClientXML);
SET @LowerThreshold = @LowerThreshold + @Range
END;
-- Add closing root element
INSERT INTO XMLOutput (XMLCol, SortID)
VALUES ('</ROOT > ', @LowerThreshold + 1);
-- Export the data
EXEC Master..xp_cmdshell 'BCP "SELECT XMLCol FROM CarSales.dbo.XMLOutput" QUERYOUT
C:\SQL2012DIRecipes\CH07\XMLOut.xml -w -SADAM_01\Adam -T'
-- Clean up the table
DROP TABLE XMLOutput