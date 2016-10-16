CREATE TABLE CarSales_Staging.dbo.SimpleParallelLoad
(
ID INT IDENTITY(1,1) NOT NULL,
FileName VARCHAR (250) NULL,
ProcessNumber AS (ID%(4))
) ;
GO