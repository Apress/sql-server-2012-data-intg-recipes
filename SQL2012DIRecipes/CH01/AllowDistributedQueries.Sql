EXECUTE master.dbo.sp_configure 'show advanced options', 1;
GO
reconfigure ;
GO
EXECUTE master.dbo.sp_configure 'ad hoc distributed queries', 1 ;
GO
reconfigure;
GO