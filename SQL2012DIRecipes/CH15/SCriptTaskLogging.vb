Public Sub Main()
Try
'Some code here
Dim nullByte() As Byte
Dts.Log("Write to log that all has worked", 0, nullByte)
Catch ex As Exception
Dts.Log(ex.Message, 0, nullByte) 'Log the error message
End Try
Dts.TaskResult = ScriptResults.Success
End Sub