Public Overrides Sub Input0_ProcessInputRow(ByVal Row As Input0Buffer)
Dim CarRow As String
Dim regexTxt As System.Text.RegularExpressions.Regex = New System.Text.RegularExpressions.Regex("[A-Z]", RegexOptions.IgnoreCase)
Dim regexNum As System.Text.RegularExpressions.Regex = New System.Text.RegularExpressions.Regex("[0-9]")
CarRow = CStr(Row.Car)
CarRow = regexTxt.Replace(CarRow, "X")
CarRow = regexNum.Replace(CarRow, "N")
Row.CarPattern = CarRow
End Sub