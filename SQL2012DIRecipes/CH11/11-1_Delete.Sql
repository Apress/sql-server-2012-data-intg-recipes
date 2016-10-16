DELETE
FROM dbo.Invoice_Lines
WHERE ID IN
(SELECT dbo.Invoice_Lines.ID
FROM dbo.Invoice_Lines
LEFT OUTER JOIN dbo.Invoice_Lines_Deletes
ON dbo.Invoice_Lines.ID = dbo.Invoice_Lines_Deletes.ID
WHERE (dbo.Invoice_Lines_Deletes.ID IS NULL))