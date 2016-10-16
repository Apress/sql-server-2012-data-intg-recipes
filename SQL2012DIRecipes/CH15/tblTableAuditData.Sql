CREATE TABLE dbo.TableAuditData
(
ID INT IDENTITY(1,1) NOT NULL,
QualifiedTableName VARCHAR(500) NULL,
LastUpdatedDate DATETIME NULL,
LastRunID INT,
LastRecordCount BIGINT
)