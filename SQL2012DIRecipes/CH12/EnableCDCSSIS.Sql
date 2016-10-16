USE CarSales;
GO
sys.sp_cdc_enable_db;
GO
sys.sp_cdc_enable_table
@source_schema = 'dbo',
@source_name = 'Client' ,
@role_name = 'CDCMainRole',
@supports_net_changes = 1