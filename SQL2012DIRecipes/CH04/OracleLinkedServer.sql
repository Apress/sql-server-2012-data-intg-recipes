EXECUTE master.dbo.sp_addlinkedserver
@server = 'MyOracleDatabase',
@srvproduct = 'Oracle',
@provider = 'OraOLEDB.Oracle',
@datasrc = 'MyOracle';
EXECUTE master.dbo. sp_addlinkedsvrlogin
@rmtsrvname = 'MyOracleDatabase',
@useself = 'false',
@locallogin = NULL,
@rmtuser = 'SCOTT', -- The Oracle User name
@rmtpassword = 'Tiger'; -- The Oracle User password



SELECT *
INTO dbo.MyOracleTable
FROM MyOracleDatabase..SCOTT.EMP;

SELECT *
INTO dbo.MyOracleTable
FROM MyOracleDatabase.. SCOTT.EMP
WHERE 1 = 0;

SELECT *
INTO dbo.MyOracleTable
FROM OPENQUERY(MyOracleDatabase,'select * from SCOTT.EMP');

EXEC ('SELECT * FROM SCOTT.EMP') AT MyOracleDatabase;

INSERT INTO dbo.MyOracleTable
EXEC ('SELECT * FROM SCOTT.EMP') AT MyOracleDatabase;

DECLARE @EMPNO INT = 7369;
INSERT INTO dbo.MyOracleTable
EXEC ('SELECT * FROM SCOTT.EMP WHERE EMPNO = ' + @EMPNO ) AT MyOracleDatabase

INSERT INTO dbo.SCOTT_EMP
EXEC (BEGIN SCOTT.MyPLSQLProcedurehere; END) AT MyOracleDatabase;












