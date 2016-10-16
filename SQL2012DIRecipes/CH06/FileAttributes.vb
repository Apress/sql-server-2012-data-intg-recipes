Public Overrides Sub CreateNewOutputRows()
Dim DrInfo As New IO.DirectoryInfo("C:\SQL2012DIRecipes\CH06")
Dim fInfo As IO.FileInfo() = DrInfo.GetFiles("*.jpg")
For Each FI In fInfo
SourceOutputBuffer.AddRow()
SourceOutputBuffer.FullPath = FI.FullName
SourceOutputBuffer.FileName = FI.Name
SourceOutputBuffer.FileExtension = FI.Extension
SourceOutputBuffer.DirectoryName = FI.DirectoryName
SourceOutputBuffer.FileSize = FI.Length
SourceOutputBuffer.DateCreated = File.GetCreationTime(FI.FullName)
SourceOutputBuffer.DateModified = File.GetLastWriteTime(FI.FullName)
Next
End Sub