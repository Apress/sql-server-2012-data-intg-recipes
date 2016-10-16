Public Sub Main()
'Declare all variables
Dim FileSource As String = Dts.Variables("FileSource").Value.ToString
Dim FileFilter As String = Dts.Variables("FileFilter").Value.ToString
Dim SortColumn As String = Dts.Variables("SortColumn").Value.ToString
Dim MainDS As New System.Data.DataSet
Dim MainTable As New System.Data.DataTable
Dim MainRow As System.Data.DataRow
Dim MainCol As New System.Data.DataColumn
Dim dirInfo As New System.IO.DirectoryInfo(FileSource)
Dim fileSystemInfo As System.IO.FileSystemInfo
Dim FileCounter As Int16 = 0
Dim FileName As String
Dim FileFullName As String
Dim FileSize As Long
Dim FileExtension As String
Dim CreationTime As Date
Dim DirectoryName As String
Dim LastWriteTime As Date
' Define table structure
MainDS.Tables.Add(MainTable)
MainTable.Columns.Add("FileName", System.Type.GetType("System.String")) ' 0
MainTable.Columns.Add("DateAdded", System.Type.GetType("System.DateTime")) ' 1
MainTable.Columns.Add("DateLoaded", System.Type.GetType("System.DateTime")) ' 2
MainTable.Columns.Add("FileSize", System.Type.GetType("System.Int32")) ' 3
MainTable.Columns.Add("CreationTime", System.Type.GetType("System.DateTime")) ' 4
MainTable.Columns.Add("FileExtension", System.Type.GetType("System.String")) ' 5
MainTable.Columns.Add("DirectoryName", System.Type.GetType("System.String")) ' 6
MainTable.Columns.Add("LastWriteTime", System.Type.GetType("System.DateTime")) ' 7
' Loop through directory, and add records to the ADO table
For Each fileSystemInfo In dirInfo.GetFileSystemInfos(FileFilter)
FileName = fileSystemInfo.Name
FileFullName = fileSystemInfo.FullName
Dim fileDetail As New FileInfo(FileFullName)
FileSize = fileDetail.Length
CreationTime = fileDetail.CreationTime
FileExtension = fileDetail.Extension
DirectoryName = fileDetail.DirectoryName
LastWriteTime = fileDetail.LastWriteTime
MainRow = MainTable.NewRow()
MainRow(0) = FileName
MainRow(1) = Now()
MainRow(2) = CDate("01-01-1900")
MainRow(3) = FileSize
MainRow(4) = CreationTime
MainRow(5) = FileExtension
MainRow(6) = DirectoryName
MainRow(7) = LastWriteTime
MainTable.Rows.Add(MainRow)
FileCounter = CShort(FileCounter + 1)
Next
' Create ADOLoopTable - used for the actual batch loop
Dim SortedFilteredDS As System.Data.DataSet = MainDS.Clone
Dim SortedFilteredRows As DataRow() = MainDS.Tables(0).[Select]("FileSize > 1", & SortColumn & " ASC")
Dim SortedFilteredTable As DataTable = SortedFilteredDS.Tables(0)
For Each ClonedFilteredRow As DataRow In SortedFilteredRows
SortedFilteredTable.ImportRow(ClonedFilteredRow)
Next
' Convert the tables into SSIS objects:
Dts.Variables("ADOFilteredAndSortedTable").Value = CType(SortedFilteredDS, Object)
Dts.TaskResult = ScriptResults.Success
End Sub