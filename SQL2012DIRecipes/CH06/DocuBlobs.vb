Public Sub Main()
Dim sDocName As String
sDocName = Dts.Variables("DocFullName").Value.ToString
Dts.Variables("DocType").Value = Right(Path.GetExtension(sDocName), 3)
Dts.Variables("DocPath").Value = Path.GetDirectoryName(sDocName)
Dts.Variables("DocName").Value = Path.GetFileName(sDocName)
Dts.TaskResult = ScriptResults.Success
End Sub