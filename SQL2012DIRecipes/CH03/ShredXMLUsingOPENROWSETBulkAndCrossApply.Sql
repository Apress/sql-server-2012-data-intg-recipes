INSERT INTO XmlImport_Clients (ID, ClientName, Town, County, Country)
SELECT
SRC.Client.value('ID[1]', 'INT') AS ID
,SRC.Client.value('ClientName[1]', 'VARCHAR(50)') AS ClientName
,SRC.Client.value('Town[1]', 'VARCHAR(50)') AS Town
,SRC.Client.value('County[1]', 'VARCHAR(50)') AS County
,SRC.Client.value('Country[1]', 'INT') AS Country
FROM
(
SELECT CAST(XMLSource AS XML)
FROM OPENROWSET(BULK 'C:\SQL2012DIRecipes\CH03\Clients_Simple.xml', SINGLE_BLOB) AS X (XMLSource)
) AS X (XMLSource)
CROSS APPLY XMLSource.nodes('CarSales/Client') AS SRC (Client);