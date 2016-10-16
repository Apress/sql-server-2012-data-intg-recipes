Dim StartTime As Date = Now()
Dim cnMgr As SqlClient.SqlConnection
cnMgr = DirectCast(Dts.Connections("CarSales_ADONET").AcquireConnection(Dts.Transaction), SqlClient.SqlConnection)
Dim cmd As New SqlClient.SqlCommand
cmd.CommandText = "Log.pr_LogEvents"
cmd.CommandType = CommandType.StoredProcedure
cmd.Parameters.AddWithValue("Process", DbType.String).Value = Dts.Variables("PackageName").Value
cmd.Parameters.AddWithValue("Step", DbType.String).Value = Dts.Variables("TaskName").Value
cmd.Parameters.AddWithValue("StartTime", DbType.DateTime).Value = StartTime
cmd.Parameters.AddWithValue("Comments", DbType.String).Value = "This seems to have worked!"
cmd.ExecuteNonQuery()
Dts.Connections("CarSales_Logging_ADONET").ReleaseConnection(Nothing)
Dts.TaskResult = ScriptResults.Success