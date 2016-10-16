SELECT
project_name
,package_name
,CASE status
WHEN 1 THEN 'Created'
WHEN 2 THEN 'Running'
WHEN 3 THEN 'Cancelled'
WHEN 4 THEN 'Failed'
WHEN 5 THEN 'Pending'
WHEN 6 THEN 'Ended unexpectedly'
WHEN 7 THEN 'Succeeded'
WHEN 8 THEN 'Stopping'
WHEN 9 THEN 'Completed'
END AS StatusFullDescription
,CONVERT(VARCHAR(25),start_time,103) AS RunDate
,CONVERT(VARCHAR(25),start_time,108) AS RunTime
,DATEDIFF(ss, start_time, end_time) AS ExecutionDurationInSeconds
,available_physical_memory_kb
,total_physical_memory_kb
FROM SSISDB.catalog.executions
WHERE execution_id = @execution_id