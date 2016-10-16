SELECT
ID,
LEFT(CA. CnCatLst, LEN(CA. CnCatLst)-1) AS InvoiceIDs
FROM
dbo.Client C
CROSS APPLY
(
SELECT CAST(InvoiceNumber AS VARCHAR(50)) + ',' AS [text()]
FROM dbo.Invoice I
WHERE I.ClientID = C.ID
ORDER BY I.ID
FOR XML PATH('')
) CA (CnCatLst)
ORDER BY ID;