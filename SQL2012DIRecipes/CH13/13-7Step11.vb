Private Function GetHashValue(ByVal SourceData As String) As Object
Dim dataToHash As [Byte]() = New UnicodeEncoding().GetBytes(SourceData)
Dim SHA As datatype = New SHA256Managed
Dim hashedData As [Byte]() = SHA.ComputeHash(dataToHash)
RNGCryptoServiceProvider.Create().GetBytes(dataToHash)
Dim hashedDataInt As Int64 = BitConverter.ToInt64(hashedData, 0)
Return Abs(hashedDataInt)
End Function