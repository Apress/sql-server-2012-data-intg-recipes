DECLARE @execution_id bigint
EXECUTE SSISDB.catalog.create_execution
@package_name=N'Test.dtsx'
,@execution_id=@execution_id OUTPUT
,@folder_name=N'Logging'
,@project_name=N'Tests'
,@use32bitruntime=False
,@reference_id=Null
EXECUTE SSISDB.catalog.set_execution_parameter_value @execution_id, 50,
'LOGGING_LEVEL', 3 -- Verbose
EXECUTE SSISDB.catalog.start_execution @execution_id
SELECT @execution_id -- Returns the execution ID for later querying