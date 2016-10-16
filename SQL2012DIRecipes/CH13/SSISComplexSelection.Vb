Public Sub Main()
' Declare and populate an array with folder names
Dim MultipleFolderNames As New System.Collections.ArrayList()
MultipleFolderNames.Add("C:\SQL2012DIRecipes\CH13\MultipleFlatFiles")
MultipleFolderNames.Add("C:\SQL2012DIRecipes\CH13\MoreMultipleFlatFiles")
' Declare and populate an array with file extensions
Dim MultipleFileExtensions As New System.Collections.ArrayList()
MultipleFileExtensions.Add("*.Csv")
MultipleFileExtensions.Add("*.txt")
' Pass the arrays to SSIS variables
Dts.Variables("MultipleFileExtensions").Value = CObj(MultipleFileExtensions)
Dts.Variables("MultipleFolderNames").Value = CObj(MultipleFolderNames)
Dts.TaskResult = ScriptResults.Success
End Sub