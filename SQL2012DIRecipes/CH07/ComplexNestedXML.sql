SELECT
C.ID
,C.ClientName
,C.Country
,C.Town
,I.TotalDiscount AS 'Invoice/@TotalDiscount'
,I.InvoiceNumber AS 'Invoice/InvoiceNumber'
FROM dbo.Client C
INNER JOIN dbo.Invoice I
ON C.ID = I.ClientID
FOR XML PATH('Client'), ROOT('CarSales');