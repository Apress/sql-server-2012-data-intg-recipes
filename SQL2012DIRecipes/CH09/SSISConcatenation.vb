Public Class ScriptMain
Inherits UserComponent

Dim InitValue As String = ""
Dim ControlValue As String = ""
Dim CurrentElement As String = ""
Dim ConcatValue As New StringBuilder
Dim ConcatCharacter As String = ","



Public Overrides Sub PreExecute()
MyBase.PreExecute()
End Sub
Public Overrides Sub PostExecute()
MyBase.PostExecute()
End Sub
Public Overrides Sub Input0_ProcessInput(ByVal Buffer As Input0Buffer)
While Buffer.NextRow()
Input0_ProcessInputRow(Buffer)
End While
If Buffer.EndOfRowset Then
Output0Buffer.AddRow()
Output0Buffer.GroupOutput = ControlValue
Output0Buffer.ListOutput = ConcatValue.Remove(ConcatValue.Length - 1, 1).ToString
Output0Buffer.SetEndOfRowset()
End If
End Sub


Public Overrides Sub Input0_ProcessInputRow(ByVal Row As Input0Buffer)
' If first record - initialise variables
If InitValue = "" Then
InitValue = Row.ClientID.ToString
ControlValue = Row.ClientID.ToString
End If
CurrentElement = Row.InvoiceNumber.ToString
ControlValue = Row.ClientID.ToString
'Process all records
If InitValue = ControlValue Then
ConcatValue = ConcatValue.Append(CurrentElement).Append(ConcatCharacter)
Else
' Write grouping element and concatenated string to new outputs
Output0Buffer.AddRow()
Output0Buffer.ListOutput = ConcatValue.Remove(ConcatValue.Length - 1, 1).ToString
Output0Buffer.GroupOutput = InitValue
InitValue = Row.ClientID.ToString
ConcatValue = ConcatValue.Remove(0, ConcatValue.Length).Append(CurrentElement).Append(ConcatCharacter)
End If
End Sub

End Class