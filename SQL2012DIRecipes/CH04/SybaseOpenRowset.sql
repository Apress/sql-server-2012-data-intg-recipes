SELECT *
INTO MySybaseASETable
FROM OPENROWSET ('ASEOLEDB', 'WIN-491Q1DHMHOF:5000';'Adam';'Me4B0ss', 'select au_lname from dbo.authors');