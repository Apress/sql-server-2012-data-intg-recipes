SELECT Lnk.ClientName
INTO MyTable
FROM OPENROWSET('SQLNCLI', 'Server=ADAM02;Trusted_Connection=yes;',
'SELECT ClientName
FROM CarSales.dbo.Client
ORDER BY ClientName') AS Lnk;