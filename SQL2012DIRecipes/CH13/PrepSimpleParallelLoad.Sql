USE CarSales_Staging
GO
SET IDENTITY_INSERT dbo.SimpleParallelLoad ON
GO
INSERT dbo.SimpleParallelLoad (ID, FileName)
VALUES (1, N'C:\SQL2012DIRecipes\CH13\MultipleFlatFiles\Stock01.Csv')
GO
INSERT dbo.SimpleParallelLoad (ID, FileName)
VALUES (2, N'C:\SQL2012DIRecipes\CH13\MultipleFlatFiles\Stock02.Csv')
GO
INSERT dbo.SimpleParallelLoad (ID, FileName)
VALUES (3, N'C:\SQL2012DIRecipes\CH13\MultipleFlatFiles\Stock03.Csv')
GO
INSERT dbo.SimpleParallelLoad (ID, FileName)
VALUES (4, N'C:\SQL2012DIRecipes\CH13\MultipleFlatFiles\Stock04.Csv')
GO
SET IDENTITY_INSERT dbo.SimpleParallelLoad OFF
GO