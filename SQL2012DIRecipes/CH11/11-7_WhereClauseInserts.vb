Public Sub Main()
Dim SB As New StringBuilder
Dim DA As New OleDbDataAdapter
Dim DT As New DataTable
Dim RW As DataRow
Dim sMsg As String = ""
DA.Fill(DT, Dts.Variables("DeltaInserts").Value)
For Each RW In DT.Rows
SB.Append(RW(0).ToString & ",")
Next
Dts.Variables("InsertSQL").Value = Dts.Variables("InsertSQL").Value.ToString & " WHERE ID IN (" & SB.ToString.TrimEnd(",") & ")"
Dts.TaskResult = ScriptResults.Success
End Sub