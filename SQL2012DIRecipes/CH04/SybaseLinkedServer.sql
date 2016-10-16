EXECUTE master.dbo.sp_addlinkedserver
@server = 'MySybaseASEDatabase',
@srvproduct = 'Sybase ASE',
@provider = 'MSDASQL',
@datasrc = 'MyASEODBC' ;


EXECUTE master.dbo.sp_addlinkedsrvloginSP_ADDLINKEDSRVLOGIN @rmtsrvname = 'MySybaseASEDatabase',
@useself = 'false',
@locallogin = NULL,
@rmtuser = 'Adam', -- The Sybase ASE User name
@rmtpassword = 'Me4B0ss' ; -- The Sybase ASE User password

SELECT *
INTO SybaseTable
FROM MySybaseASEDatabase.pubs2.dbo.authors;