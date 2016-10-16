Public Overrides Sub CreateNewOutputRows()
Dim WMIdataTable As System.Data.DataTable
Dim WMIdataRow As System.Data.DataRow
WMIdataTable = CType(Me.Variables.oWMI, Data.DataTable)
For Each WMIdataRow In WMIdataTable.Rows
Output0Buffer.AddRow()
Output0Buffer.EventIdentifier = CULng(WMIdataRow.Item("EventIdentifier"))
Output0Buffer.EventCode = CInt(WMIdataRow.Item("EventCode"))
Output0Buffer.EventType = CInt(WMIdataRow.Item("EventType"))
Output0Buffer.Message = WMIdataRow.Item("Message").ToString
Output0Buffer.TimeGenerated = WMIdataRow.Item("TimeGenerated").ToString
Next
Output0Buffer.SetEndOfRowset()
End Sub