Public Class ScriptMain
Inherits UserComponent
Dim NullCounter As Integer
Dim RowCounter As Integer
Public Overrides Sub PreExecute()
MyBase.PreExecute()
End Sub
Public Overrides Sub PostExecute()
If (NullCounter / RowCounter) >= 0.25 Then
Me.Variables.IsSafeToProceed = False
End If
End Sub
Public Overrides Sub Input0_ProcessInputRow(ByVal Row As Input0Buffer)
If Row.InvoiceNumber_IsNull Then
NullCounter = NullCounter + 1
End If
RowCounter = RowCounter + 1
End Sub
End Class