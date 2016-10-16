EXECUTE master.dbo.sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXECUTE master.dbo.sp_configure 'ad hoc distributed queries', 1;
GO
RECONFIGURE;
GO