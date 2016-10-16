SELECT
message_time
,CASE message_type
WHEN -1 THEN 'Unknown'
WHEN 10 THEN 'Pre-validate'
WHEN 20 THEN 'Post-validate'
WHEN 30 THEN 'Pre-execute'
WHEN 40 THEN 'Post-execute'
WHEN 50 THEN 'StatusChange'
WHEN 60 THEN 'Progress'
WHEN 70 THEN 'Information'
WHEN 80 THEN 'VariableValueChanged'
WHEN 90 THEN 'Diagnostic'
WHEN 100 THEN 'QueryCancel'
WHEN 110 THEN 'Warning'
WHEN 120 THEN 'Error'
WHEN 130 THEN 'TaskFailed'
WHEN 140 THEN 'DiagnosticEx'
WHEN 200 THEN 'Custom'
WHEN 400 THEN 'NonDiagnostic'
END AS MessageType
,CASE message_source_type
WHEN 10 THEN 'Entry APIs, such as T-SQL and CLR Stored procedures'
WHEN 20 THEN 'External process used to run package (ISServerExec.exe)'
WHEN 30 THEN 'Package-level objects'
WHEN 40 THEN 'Control Flow tasks'
WHEN 60 THEN 'Control Flow containers'
WHEN 50 THEN 'Data Flow task'
END AS MessageSourceType
,message
,extended_info_id
FROM SSISDB.catalog.operation_messages
WHERE operation_id = @ExecutionID
ORDER BY operation_message_id