CREATE TABLE CarSales_Logging.Log.RefTables
(
ID INT IDENTITY(1,1) NOT NULL,
DatabaseName VARCHAR(150) NULL,
SchemaName VARCHAR(150) NULL,
TableName VARCHAR(150) NULL,
TableMaxThreshold BIGINT NULL,
TableMinThreshold BIGINT NULL,
TablePercentAcceptableVariation NUMERIC(8, 4) NULL
)
CREATE TABLE CarSales_Logging.Log.RefBaselineProcessess
(
ID INT IDENTITY(1,1) NOT NULL,
ProcessName VARCHAR(150) NULL,
ProcessMaxThreshold BIGINT NULL,
ProcessMinThreshold BIGINT NULL,
ProcessPercentAcceptableVariation NUMERIC(8, 4) NULL
)
CREATE TABLE CarSales_Logging.Log.RefBaselineCounters
(
ID INT IDENTITY(1,1) NOT NULL,
CounterName VARCHAR(150) NULL,
CounterComments VARCHAR(4000) NULL,
CounterMinThreshold INT NULL,
CounterMaxThreshold INT NULL,
CounterPercentAcceptableVariance INT NULL
)
