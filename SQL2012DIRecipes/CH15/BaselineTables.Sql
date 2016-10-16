CREATE TABLE CarSales_Logging.Log.TableSize
(
ID INT IDENTITY(1,1) NOT NULL,
TableSchema VARCHAR(50) NULL,
TableName VARCHAR(50) NULL,
SpaceUsedKB BIGINT NULL,
SpaceReservedKB BIGINT NULL,
Rowcounts BIGINT NULL,
RunID INT NULL,
DateUpdated DATE NULL
)
CREATE TABLE CarSales_Logging.Log.ProcessCounterBaseline
(
ID INT IDENTITY(1,1) NOT NULL,
RunID INT NULL,
CounterName VARCHAR(150) NULL,
CounterNumber BIGINT NULL
)
CREATE TABLE CarSales_Logging.Log.ProcessBaseline
(
ID INT IDENTITY(1,1) NOT NULL,
RunID INT NULL,
ProcessName VARCHAR(150) NULL,
ProcessDuration INT NULL
)