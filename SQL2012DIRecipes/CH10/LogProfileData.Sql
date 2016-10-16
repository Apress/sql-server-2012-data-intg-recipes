DECLARE @Rowcount INT;
DECLARE @Model_NULL INT;
DECLARE @Mileage_NULL INT
DECLARE @Model_PERCENTNULL NUMERIC(8,4);
DECLARE @Mileage_PERCENTNULL NUMERIC(8,4);
DECLARE @Model_MAXLENGTH INT;
DECLARE @Model_MINLENGTH INT;
DECLARE @Mileage_MAX INT;
DECLARE @Mileage_MIN INT;
SELECT @Rowcount = COUNT(*),
@Mileage_MAX = MAX(Mileage),
@Mileage_MIN = MIN(Mileage),
@Model_MAXLENGTH = MAX(LEN(Model)),
@Model_MINLENGTH = MIN(LEN(Model))
FROM CarSales.dbo.Stock;
SELECT @Model_NULL = COUNT(*)
FROM CarSales.dbo.Stock
WHERE Model IS NULL;


SELECT @Mileage_NULL = COUNT(*)
FROM CarSales.dbo.Stock
WHERE Mileage IS NULL;
SET @Model_PERCENTNULL = CAST(@Model_NULL AS NUMERIC(5,2)) / CAST(@Rowcount AS NUMERIC(5,2));
SET @Mileage_PERCENTNULL = CAST(@Mileage_NULL AS NUMERIC(5,2)) / CAST(@Rowcount AS NUMERIC(5,2));
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,
ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'ALL', 'NbRows', @Rowcount, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Mileage', 'MaxMileage', @Mileage_MAX, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Mileage', 'MinMileage', @Mileage_MIN, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Model', 'MaxLn_Model', @Model_MAXLENGTH, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Model', 'MinLn_Model', @Model_MINLENGTH, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Model', 'NbNulls_Model', @Model_NULL, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Mileage', 'NbNulls_Mileage',@Mileage_NULL, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Model', 'PctNulls_Model',@Model_PERCENTNULL, 100);
INSERT INTO CarSales_Staging.dbo.DataProfiling (DataSourceObject, DataSourceColumn,ProfileName, ProfileResult)
VALUES ('CarSales_Staging.dbo.Stock', 'Mileage', 'PctNulls_Mileage', @Mileage_PERCENTNULL, 100);