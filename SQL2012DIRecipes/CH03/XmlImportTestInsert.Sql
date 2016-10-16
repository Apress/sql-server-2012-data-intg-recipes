INSERT INTO XmlImportTest(XMLDataStore, Keyword);
SELECT XMLDATAToStore, 'Attribute-Centric' AS ColType
FROM
(
SELECT CONVERT(XML, XMLCol, 0)
FROM OPENROWSET (BULK 'C:\SQL2012DIRecipes\CH03\Clients_Simple.Xml' ,
SINGLE_BLOB) AS XMLSource (XMLCol)
) AS XMLFileToImport (XMLDATAToStore);