CREATE TRIGGER CarSales.dbo.tr_DeltaTracking
ON dbo.Invoice_Lines FOR INSERT, UPDATE, DELETE
AS
DECLARE @InsertedCount BIGINT
DECLARE @DeletedCount BIGINT
DECLARE @ObjectName NVARCHAR(128)
SELECT @InsertedCount = COUNT(*) FROM INSERTED
SELECT @DeletedCount = COUNT(*) FROM DELETED
SELECT @ObjectName = OBJECT_NAME(parent_id)
FROM sys.triggers
WHERE parent_class_desc = 'OBJECT_OR_COLUMN'
AND object_id = @PROCID
-- Inserts
IF @InsertedCount > 0 AND @DeletedCount = 0
BEGIN
INSERT INTO dbo.DeltaTracking (RecordID, ObjectName, DeltaOperation)
SELECT
ID
,@ObjectName AS ObjectID
,'I' AS DeltaOperation
FROM INSERTED
END
-- Deletes
IF @InsertedCount = 0 AND @DeletedCount > 0
BEGIN
INSERT INTO dbo.DeltaTracking (RecordID, ObjectName, DeltaOperation)
SELECT
ID
,@ObjectName AS ObjectID
,'D' AS DeltaOperation
FROM DELETED
END
-- Updates
IF @InsertedCount > 0 AND @DeletedCount > 0
BEGIN
INSERT INTO dbo.DeltaTracking (RecordID, ObjectName, DeltaOperation)
SELECT
ID
,@ObjectName AS ObjectID
,'U' AS DeltaOperation
FROM INSERTED
END
GO