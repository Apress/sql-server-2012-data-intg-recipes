UPDATE XmlImportTest
SET XMLDataStore =
(
SELECT XMLDATAToStore
FROM
(
SELECT CONVERT(XML, XMLCol, 0)
FROM OPENROWSET (BULK
' C:\SQL2012DIRecipes\CH03\Clients_Simple.Xml',
SINGLE_BLOB) AS XMLSource (XMLCol)
) AS XMLFileToImport (XMLDATAToStore)
)
WHERE Keyword = 'Attribute-Centric'