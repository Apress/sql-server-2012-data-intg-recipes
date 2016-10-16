Public Class ScriptMain
Inherits UserComponent
Dim ConnMgr As IDTSConnectionManager100
Dim SQLConn As SqlConnection
Dim SQLReader As SqlDataReader
Dim DSTable As DataTable
Public Overrides Sub AcquireConnections(ByVal Transaction As Object)
ConnMgr = Me.Connections.ADONETSource
SQLConn = CType(ConnMgr.AcquireConnection(Nothing), SqlConnection)
End Sub
Public Overrides Sub PreExecute()
MyBase.PreExecute()
DSTable = SQLConn.GetSchema("Tables")
End Sub
Public Overrides Sub PostExecute()
MyBase.PostExecute()
End Sub
Public Overrides Sub CreateNewOutputRows()
For Each Row In DSTable.Rows
MetadataOutputBuffer.AddRow()
MetadataOutputBuffer.TableCatalog = Row("TABLE_CATALOG").ToString
MetadataOutputBuffer.TableSchema = Row("TABLE_SCHEMA").ToString
MetadataOutputBuffer.TableName = Row("TABLE_NAME").ToString
MetadataOutputBuffer.TableType = Row("TABLE_TYPE").ToString
Next
End Sub
End Class