Public Sub Main()
Dim fileName As String
Dim filePath As String
Dim streamWriter As StreamWriter
Dim fileData As String
Figure 7-13. Building an expression to run BCP
Dim WriteBuffer As Byte()
Dim GZStream As GZipStream
fileName = Dts.Variables("sTableName").Value.ToString
filePath = Dts.Variables("FilePath").Value.ToString
Dim fileStream As New FileStream(filePath & fileName, FileMode.Open, FileAccess.Read)
WriteBuffer = New Byte(CInt(fileStream.Length)) {}
fileStream.Read(WriteBuffer, 0, WriteBuffer.Length)
Dim strDestinationFileName As String
strDestinationFileName = filePath & fileName & ".gz"
Dim fileStreamDestination As New FileStream(strDestinationFileName, FileMode.OpenOrCreate, FileAccess.Write)
GZStream = New GZipStream(fileStreamDestination, CompressionMode.Compress, True)
GZStream.Write(WriteBuffer, 0, WriteBuffer.Length)
fileStream.Close()
GZStream.Close()
fileStreamDestination.Close()
Dts.TaskResult = Dts.Results.Success
End Sub