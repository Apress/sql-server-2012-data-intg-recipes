SELECT
ID
,Make
,Marque
,Model
,Registration_Date
,Mileage
,ID % 2 AS ProcessNumber
FROM dbo.Stock