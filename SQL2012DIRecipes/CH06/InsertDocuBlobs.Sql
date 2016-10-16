INSERT INTO CarSales_Staging.dbo.DocuBlobs
(
ExternalFileName,
ExternalFileDirectory,
FileData,
FileType
)
SELECT
'MyWordDocument.doc',
'C:\SQL2012DIRecipes\CH06\', (SELECT * FROM OPENROWSET(BULK 'C:\SQL2012DIRecipes\CH06\MyWordDocument.doc', SINGLE_BLOB) AS MyDoc ),
'Doc' ;