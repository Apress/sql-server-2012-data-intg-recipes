BACKUP DATABASE CarSales TO DISK=' C:\SQL2012DIRecipes\CH05\CopyOnlyDatabase.bak'
WITH INIT, COPY_ONLY

RESTORE DATABASE CopyOnlyDatabase
FROM DISK = N' C:\SQL2012DIRecipes\CH05\CopyOnlyDatabase.bak'
WITH REPLACE,
MOVE 'CarSales' TO ' C:\SQL2012DIRecipes\CH05\CopiedDatabase.Mdf',
MOVE 'CarSales_log' TO ' C:\SQL2012DIRecipes\CH05\CopiedDatabase.ldf'