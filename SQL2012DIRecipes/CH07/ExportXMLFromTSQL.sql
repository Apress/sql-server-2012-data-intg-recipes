IF OBJECT_ID('dbo.XMLOutput') IS NOT NULL DROP TABLE XMLOutput;
CREATE TABLE XMLOutput (XMLCol XML);
INSERT INTO XMLOutput (XMLCol)
SELECT XMLOut FROM
(
SELECTC.ID, ClientName, Country, Town
FROMCarSales.dbo.Client C
FOR XML PATH('Client'), ROOT('RootElement')
) A (XMLOut);
EXEC Master.dbo.xp_cmdshell
'BCP CarSales.dbo.XMLOutput OUT C:\SQL2012DIRecipes\CH07\XMLOut.xml –w –SADAM02 -T'