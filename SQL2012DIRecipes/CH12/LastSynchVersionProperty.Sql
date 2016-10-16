USE CarSales;
GO
EXECUTE sys.sp_addextendedproperty
@level0type = N'SCHEMA'
,@level0name = dbo
,@level1type = N'TABLE'
,@level1name = Client
,@name = LAST_SYNC_VERSION
,@value = 0
;