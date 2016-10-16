SELECT
executable_id
,execution_id
,executable_name
,package_name
,package_path
FROM SSISDB.catalog.executables
WHERE execution_id = @execution_id