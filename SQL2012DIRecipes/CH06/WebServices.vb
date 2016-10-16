Public Sub Main()
Dim xDdoc As New Xml.XmlDocument
xDdoc.LoadXml(Dts.Variables("XMLOutput").Value.ToString)
Dts.Variables("ConversionRate").Value = CDbl(xDdoc.SelectSingleNode("double[1]").InnerText)
Dts.TaskResult = ScriptResults.Success
End Sub