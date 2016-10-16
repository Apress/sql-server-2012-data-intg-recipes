DECLARE @DocID INT;
DECLARE @DocXML VARCHAR(MAX);
SELECT @DocXML = CAST(XMLSource AS VARCHAR(MAX))
FROM OPENROWSET(BULK 'C:\SQL2012DIRecipes\CH03\ClientLite.xml', SINGLE_BLOB) AS X (XMLSource);
EXECUTE master.dbo.sp_xml_preparedocument @DocID OUTPUT, @DocXML;
SELECT ID, ClientName, Country
INTO XmlTable
FROM OPENXML(@DocID, 'CarSales/Client', 2)
WITH (
ID VARCHAR(50)
,ClientName VARCHAR(50)
,Country VARCHAR(10)
)
WHERE Country = 3
ORDER BY ID
EXECUTE master.dbo.sp_xml_removedocument @DocID;