SELECT
ID, ClientName, Town
INTO MyTable
FROM OPENDATASOURCE('SQLNCLI',
'Data Source=ADAM02\AdamRemote;Integrated Security=SSPI').CarSales.dbo.Client

SELECT ClientID
FROM OPENDATASOURCE('SQLNCLI',
'Data Source=ADAM02\ AdamRemote;User ID Adampassword=
AdamRemPwd';').CarSales.dbo.Client'