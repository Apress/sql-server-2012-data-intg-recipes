SELECT
package_name
,task_name
,dataflow_path_id_string
,dataflow_path_name
,source_component_name
,destination_component_name
,SUM(rows_sent) AS RowsSent
,execution_path
FROM SSISDB.catalog.execution_data_statistics
WHERE execution_id = @execution_id
GROUP BY
execution_id
,package_name
,task_name
,dataflow_path_id_string
,dataflow_path_name
,source_component_name
,destination_component_name
,execution_path