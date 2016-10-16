Public Sub Main()
Dim sqlConn As SqlConnection
Dim sqlCommand As SqlCommand
sqlConn = DirectCast(Dts.Connections("CarSales_Staging_ADONET").AcquireConnection(Dts.Transaction), SqlConnection)
Dim FileSource As String = Dts.Variables("FileSource").Value.ToString
Dim FileFilter As String = Dts.Variables("FileFilter").Value.ToString
Dim dirInfo As New System.IO.DirectoryInfo(FileSource)
Dim fileSystemInfo As System.IO.FileSystemInfo
Dim FileName As String
Dim sqlText As String
For Each fileSystemInfo In dirInfo.GetFileSystemInfos(FileFilter)
FileName = fileSystemInfo.Name
sqlText = "INSERT INTO dbo.SimpleParallelLoad (FileName) VALUES('" & FileName & "')"
sqlCommand = New SqlCommand(sqlText, sqlConn)
sqlCommand.CommandType = CommandType.Text
sqlCommand.ExecuteNonQuery()
Next
Dts.TaskResult = ScriptResults.Success
End Sub