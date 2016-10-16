Public Sub Main()
Dim sqlConn As SqlConnection
Dim sqlCommand As SqlCommand
sqlConn = DirectCast(Dts.Connections(Dts.Variables("ListConn").Value.ToString).AcquireConnection(Dts.Transaction), SqlConnection)
Dim FileSource As String = Dts.Variables("FileSource").Value.ToString
Dim FileFilter As String = Dts.Variables("FileFilter").Value.ToString
Dim dirInfo As New System.IO.DirectoryInfo(FileSource)
Dim fileSystemInfo As System.IO.FileSystemInfo
Dim FileName As String
Dim FileFullName As String
Dim FileSize As Long
Dim FileExtension As String
Dim CreationTime As Date
Dim DirectoryName As String
Dim LastWriteTime As Date
Dim sqlText As String
For Each fileSystemInfo In dirInfo.GetFileSystemInfos(FileFilter)
FileName = fileSystemInfo.Name
FileFullName = fileSystemInfo.FullName
Dim fileDetail As New FileInfo(FileFullName)
FileSize = fileDetail.Length
CreationTime = fileDetail.CreationTime
FileExtension = fileDetail.Extension
DirectoryName = fileDetail.DirectoryName
LastWriteTime = fileDetail.LastWriteTime
sqlText = "INSERT INTO dbo.BatchFileLoad " _
& "(FileName, IsToload, IsLoaded, FileSize, CreationTime, " _
& "FileExtension, DirectoryName, LastWriteTime) " _
& "VALUES('" & FileName & "', 1, 0, " & FileSize & ", '" _
& String.Format("{0:s}", CreationTime) & "', '" & FileExtension & "', '" _
& DirectoryName & "', '" & String.Format("{0:s}", LastWriteTime) & "')"
sqlCommand = New SqlCommand(sqlText, sqlConn)
sqlCommand.CommandType = CommandType.Text
sqlCommand.ExecuteNonQuery()
Next
Dts.TaskResult = ScriptResults.Success
End Sub