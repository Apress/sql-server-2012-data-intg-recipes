EXEC sys.sp_updateextendedproperty
@level0type = N'SCHEMA'
,@level0name = dbo
,@level1type = N'TABLE'
,@level1name = Client
,@name = LAST_SYNC_VERSION
,@value = @CurrentVersion
;