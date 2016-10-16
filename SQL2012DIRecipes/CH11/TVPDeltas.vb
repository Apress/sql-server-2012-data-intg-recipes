Public Class ScriptMain
Inherits UserComponent
Dim connMgr As IDTSConnectionManager110
Dim sqlConn As SqlConnection
Public Overrides Sub AcquireConnections(ByVal Transaction As Object)
connMgr = Me.Connections.DataBaseConnection
sqlConn = CType(connMgr.AcquireConnection(Nothing), SqlConnection)
End Sub
Public Overrides Sub PostExecute()
MyBase.PostExecute()
End Sub
Public Overrides Sub CreateNewOutputRows()
Dim DA As New OleDb.OleDbDataAdapter
Dim TBL As New DataTable
Dim Row As DataRow = Nothing
DA.Fill(TBL, Me.Variables.InsertDeltas)
Dim cmd As New SqlClient.SqlCommand("dbo.pr_SelectDeltaData", sqlConn)
cmd.CommandType = CommandType.StoredProcedure
Dim DeltaPrm As SqlClient.SqlParameter = cmd.Parameters.Add("@DeltaSet", SqlDbType.Structured)
DeltaPrm.Value = TBL
Dim RDR As SqlClient.SqlDataReader = cmd.ExecuteReader()

If RDR.HasRows = True Then
Do While RDR.Read()
With MainOutputBuffer
.AddRow()
' Map data
.ID = RDR.GetSqlInt32(0)
.InvoiceID = RDR.GetSqlInt32(1)
.StockID = RDR.GetSqlInt32(2)
.SalePrice = RDR.GetDecimal(3)
If Not RDR.GetSqlString(4).IsNull Then
.HashData = RDR.GetSqlString(4)
End If
End With
Loop
End If
End Sub
End Class