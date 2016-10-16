Imports System.IO
Imports System.Xml
Imports System.Xml.Schema
Imports System.Xml.XPath


Dim SW As StringWriter = New StringWriter
Dim IsValidateFailure As Boolean = False
Public Sub Main()
Dim XSDFile As String = Dts.Variables("XSDFile").Value.ToString
Dim XMLFile As String = Dts.Variables("XMLFile").Value.ToString
Dim LogFile As String = Dts.Variables("LogFile").Value.ToString
Dim XMLDoc As New XmlDocument
XMLDoc.Load(XMLFile)
XMLDoc.Schemas.Add("", XSDFile)
Dim EvtHdl As ValidationEventHandler = New ValidationEventHandler(AddressOf ValidationEventHandler)
XMLDoc.Validate(EvtHdl)
If IsValidateFailure Then
If File.Exists(LogFile) Then
File.Delete(LogFile)
End If
Dim FlOut As New System.IO.StreamWriter(LogFile)
FlOut.Write(SW.ToString)
End If
Dts.Variables("IsValidateFailure").Value = IsValidateFailure
Dts.TaskResult = ScriptResults.Success
End Sub
Private Sub ValidationEventHandler(ByVal sender As Object, ByVal e As ValidationEventArgs)
SW.WriteLine(e.Message.ToString)
IsValidateFailure = True
End Sub