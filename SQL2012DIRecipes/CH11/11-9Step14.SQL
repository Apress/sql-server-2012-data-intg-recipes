SELECT TRK.RecordID
FROM dbo.DeltaTracking TRK
WHERE TRK.DeltaOperation = 'D'
AND ObjectID = OBJECT_ID('dbo.Invoice_Lines')