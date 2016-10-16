Public Sub Main()
Dim SQLInsertText As String = " SELECT SRC. ID, ClientName, Country, Town, County, ? Address1, Address2, ClientType, ClientSize" _
& " FROM dbo.Client SRC" _
& " INNER JOIN CHANGETABLE(CHANGES Client, " & Dts.Variables("LastSynchVersion").Value & ") AS CT" _
& " ON SRC.ID = CT.ID" _
& " WHERE CT.SYS_CHANGE_OPERATION = 'I'"
Dts.Variables("SQLInsert").Value = SQLInsertText
Dim SQLDeleteText As String = "SELECT ID FROM CHANGETABLE(CHANGES Client, " & Dts.Variables("LastSynchVersion").Value & ") AS DEL" _
& " WHERE SYS_CHANGE_OPERATION = 'D'"
Dts.Variables("SQLDelete").Value = SQLDeleteText
Dim SQLUpdateText As String = " SELECT SRC. ID, ClientName, Country, Town, County, Address1, Address2, ClientType, ClientSize " _
& " FROM dbo.Client SRC" _
& " INNER JOIN CHANGETABLE(CHANGES Client, " & Dts.Variables("LastSynchVersion").Value & ") AS CT" _
& " ON SRC.ID = CT.ID" _
& " WHERE CT.SYS_CHANGE_OPERATION = 'U'"
Dts.Variables("SQLUpdate").Value = SQLUpdateText
Dts.TaskResult = ScriptResults.Success
End Sub