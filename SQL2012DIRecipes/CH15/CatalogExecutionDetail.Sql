SELECT
EX.executable_name
,EX.package_name
,EX.package_path
,CONVERT(VARCHAR(25),ES.start_time,100) AS StartTime
,CONVERT(VARCHAR(25),ES.end_time,100) AS EndTime
,ES.execution_duration
,CASE ES.execution_result
WHEN 0 THEN 'Success'
WHEN 1 THEN 'Failure'
WHEN 2 THEN 'Completion'
WHEN 3 THEN 'Cancelled'
END AS ExecutionResultFullDescription
,ES.execution_path
FROM SSISDB.catalog.executables EX
INNER JOIN SSISDB.catalog.executable_statistics ES
ON EX.executable_id = ES.executable_id
AND EX.execution_id = ES.execution_id
WHERE ES.execution_id = @execution_id
ORDER BY ES.start_time