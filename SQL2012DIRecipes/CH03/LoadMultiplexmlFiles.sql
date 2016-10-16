-- Used for dynamic SQL
DECLARE @SQL VARCHAR(8000) ;
-- Table variable to hold file names
DECLARE @FileList TABLE (XMLFile VARCHAR(150)) ;
-- Table variable to capture "raw" file listing
DECLARE @DirList TABLE (List VARCHAR(250)) ;
-- Load the output from the DIR command into the @DirList
-- Table variable
INSERT INTO @DirList
EXEC master.dbo.xp_cmdshell 'Dir D:\BIProject\*.Xml';
-- Parse out the file names - caveats, no spaces in file names,
-- All files have the correct and identical structure...
INSERT INTO @FileList
SELECT REVERSE(LEFT(REVERSE(List), CHARINDEX(' ', REVERSE(List))))
FROM @DirList
WHERE List LIKE '%.Xml%';
-- Cursor to loop through file names and load xml files
DECLARE @FileName VARCHAR(150);
DECLARE FileLoad_CUR CURSOR
FOR
SELECT XMLFile FROM @FileList
OPEN FileLoad_CUR

FETCH NEXT FROM FileLoad_CUR INTO @FileName
WHILE @@FETCH_STATUS <> -1
BEGIN
-- The XML load process
SET @SQL = ' INSERT INTO AA1 (XMLData) SELECT CAST(XMLSource AS XML) AS XMLSource
FROM OPENROWSET(BULK ''' + @FileName + ''', SINGLE_BLOB) AS X (XMLSource)'
EXEC (@SQL)
FETCH NEXT FROM FileLoad_CUR INTO @FileName
END;
CLOSE FileLoad_CUR;
DEALLOCATE FileLoad_CUR;