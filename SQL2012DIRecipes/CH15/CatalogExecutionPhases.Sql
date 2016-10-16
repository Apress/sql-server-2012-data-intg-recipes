SELECT
package_name
,task_name
,subcomponent_name
,execution_path
,phase
,start_time
,end_time
,DATEDIFF(ms, start_time, end_time) AS ExecutionDurationInMilliSeconds
FROM SSISDB.catalog.execution_component_phases
WHERE execution_id = @ExecutionID
ORDER BY phase_stats_id