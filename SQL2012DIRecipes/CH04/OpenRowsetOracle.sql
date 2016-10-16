SELECT *
INTO MyOracleTable
FROM OPENROWSET ('OraOLEDB.Oracle', 'MyOracle';'SCOTT';'Tiger',
'select * from SCOTT.EMP');