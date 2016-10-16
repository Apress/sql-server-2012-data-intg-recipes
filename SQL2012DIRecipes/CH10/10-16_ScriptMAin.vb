Public Class ScriptMain
    Inherits UserComponent

    Dim ColDataType(3) As Integer           ' This needs to be set to the number of columns handled (base 0)
    Dim ColDataLength(3) As Integer         ' This needs to be set to the number of columns handled (base 0)
    Dim ColDecimalPrecision(3) As Integer   ' This needs to be set to the number of columns handled (base 0)
    Dim ColDecimalScale(3) As Integer       ' This needs to be set to the number of columns handled (base 0)
    Dim ProposedDataType(17) As String

    Public Overrides Sub PreExecute()

        ProposedDataType(0) = "unknown"
        ProposedDataType(1) = "bit"
        ProposedDataType(2) = "tinyint"
        ProposedDataType(3) = "smallint"
        ProposedDataType(4) = "int"
        ProposedDataType(5) = "bigint"
        ProposedDataType(6) = "smallmoney"
        ProposedDataType(7) = "money"
        ProposedDataType(8) = "decimal"
        ProposedDataType(9) = "single"
        ProposedDataType(10) = "double"
        ProposedDataType(11) = "time"
        ProposedDataType(12) = "date"
        ProposedDataType(13) = "smalldatetime"
        ProposedDataType(14) = "datetime"
        ProposedDataType(15) = "datetime2"
        ProposedDataType(16) = "char"
        ProposedDataType(17) = "varchar"

    End Sub

    Public Overrides Sub PostExecute()
        MyBase.PostExecute()

        Dim outFile As String = "C:\SQL2012DIRecipes\CH10\Output.txt"
        Dim sb As New StringBuilder

        For i = 0 To ColDataType.Length - 1

            sb.AppendLine("Col" & i & "," & ProposedDataType(ColDataType(i)) & "," & ColDataLength(i) & "," & ColDecimalPrecision(i) & "," & ColDecimalScale(i))

        Next

        Using OutWrite As New StreamWriter(outFile)
            OutWrite.Write(sb.ToString)
        End Using

    End Sub

    Public Overrides Sub Input0_ProcessInputRow(ByVal Row As Input0Buffer)

        GetDataType(Row.ID, 0)
        GetDataType(Row.InvoiceNumber, 1)
        GetDataType(Row.DeliveryCharge, 2)
        GetDataType(Row.ClientID, 3)
        GetDataType(Row.TotalDiscount, 4)

    End Sub

    Public Function GetDataType(ByVal InputCol As String, ByVal ColIndex As Integer) As Integer

        Dim IsFound As Boolean = 0
        Dim SuggestedDataType As Integer

        Dim MaxMoney As Decimal = 922337203685477.62 ' should be .5808
        Dim MinMoney As Decimal = -922337203685477.62 ' should be .5807
        Dim MaxSmallMoney As Decimal = 214748.3647
        Dim MinSmallMoney As Decimal = -214748.3648
        Dim MinDateTime As Integer = 1753
        Dim MaxDateTime As Integer = 9999
        Dim MinSmallDateTime As Integer = 1900
        Dim MaxSmallDateTime As Integer = 2079
        Dim MinDateTime2 As Integer = 0

        Dim DecimalPrecision As Integer = 0
        Dim DecimalScale As Integer = 0
        Dim StringLength As Integer = 0

        ' no detection of decimal separator or date/time formats..

        If Boolean.TryParse(InputCol, 0) Then
            IsFound = True
            SuggestedDataType = 1
        End If

        If Not IsFound Then

            If IsNumeric(InputCol) Then  ' Initial test for numeric values

                ' Integer first - straight mapping:

                If Not IsFound Then
                    If Byte.TryParse(InputCol, 0) Then ' 0 - 256
                        IsFound = True
                        SuggestedDataType = 2
                    End If
                End If

                If Not IsFound Then
                    If Int16.TryParse(InputCol, 0) Then ' - 32768 to 32767
                        SuggestedDataType = 3
                        IsFound = True
                    End If

                End If

                If Not IsFound Then
                    If Int32.TryParse(InputCol, 0) Then ' -2147483648 to 2147483647
                        IsFound = True
                        SuggestedDataType = 4
                    End If
                End If

                If Not IsFound Then
                    If Int64.TryParse(InputCol, 0) Then ' -9223372036854775808 to 9223372036854775807
                        IsFound = True
                        SuggestedDataType = 5
                    End If
                End If


                ' If not an integer, try the decimal data types

                ' Money first
                If Not IsFound Then
                    If Decimal.TryParse(InputCol, 0) Then

                        If InputCol.Length - InputCol.IndexOf(".", 0) <= 5 Then

                            If InputCol >= MinSmallMoney And InputCol <= MaxSmallMoney Then
                                IsFound = True
                                SuggestedDataType = 6
                            End If

                            If Not IsFound Then
                                If InputCol >= MinMoney And InputCol <= MaxMoney Then
                                    IsFound = True
                                    SuggestedDataType = 7
                                End If
                            End If

                        End If

                        If InputCol.Length - InputCol.IndexOf(".", 0) > 5 Then

                            If Not IsFound Then
                                IsFound = True
                                SuggestedDataType = 8
                                DecimalPrecision = InputCol.Length - 1
                                DecimalScale = InputCol.Length - InputCol.IndexOf(".", 0) - 1
                            End If

                        End If

                    End If
                End If

                ' If not one of the other numeric types - it has to be single or double!
                If Not IsFound Then
                    If Single.TryParse(InputCol, 0) Then
                        IsFound = True
                        SuggestedDataType = 9
                    End If
                End If

                If Not IsFound Then
                    If Double.TryParse(InputCol, 0) Then
                        IsFound = True
                        SuggestedDataType = 10
                    End If
                End If


            End If
        End If

        ' Date types
        If Not IsFound Then

            Dim DV As DateTime

            If DateTime.TryParse(InputCol, DV) Then

                If IsDate(InputCol) Then


                    If Hour(InputCol) = 0 And Minute(InputCol) = 0 And Second(InputCol) = 0 Then ' has no time aspect, so is a date

                        If Year(InputCol) = 1 And Month(InputCol) = 1 Then ' Has no year/month aspect - so is a time
                            IsFound = True
                            SuggestedDataType = 11
                        End If

                        If Year(InputCol) >= MinDateTime2 And Year(InputCol) <= MaxDateTime Then
                            IsFound = True
                            SuggestedDataType = 12
                        End If

                    End If

                    If Not IsFound Then
                        If Year(InputCol) >= MinSmallDateTime And Year(InputCol) <= MaxSmallDateTime Then
                            IsFound = True
                            SuggestedDataType = 13
                        End If
                    End If

                    If Not IsFound Then
                        If Year(InputCol) >= MinDateTime And Year(InputCol) <= MaxDateTime Then
                            IsFound = True
                            SuggestedDataType = 14
                        End If
                    End If

                    If Not IsFound Then
                        If Year(InputCol) >= MinDateTime2 And Year(InputCol) <= MaxDateTime Then
                            IsFound = True
                            SuggestedDataType = 15
                        End If
                    End If

                End If

            End If

        End If

        'Then Text

        If Not IsFound Then
            SuggestedDataType = 16
            StringLength = InputCol.Length
        End If

        ' Apply the most inclusive data type

        'First, if there is a date so far, and it becomes a number (or vice-versa) - automatically becomes text
        If ((ColDataType(ColIndex) >= 1 And ColDataType(ColIndex) <= 10) And (SuggestedDataType >= 11 And SuggestedDataType <= 15)) Or ((ColDataType(ColIndex) >= 11 And ColDataType(ColIndex) <= 15) And (SuggestedDataType >= 1 And SuggestedDataType <= 10)) Then

            SuggestedDataType = 15

        End If

        ' Remember the chosen data type
        If ColDataType(ColIndex) < SuggestedDataType Then
            ColDataType(ColIndex) = SuggestedDataType
        End If

        ' For text types, set the col length
        If SuggestedDataType = 16 Then

            If InputCol.Length > ColDataLength(ColIndex) Then
                ColDataLength(ColIndex) = InputCol.Length
            End If

        End If

        ' For decimal types get precision and scale
        If SuggestedDataType = 7 Then

            If DecimalPrecision > ColDecimalPrecision(ColIndex) Then
                ColDecimalPrecision(ColIndex) = DecimalPrecision
            End If

            If DecimalScale > ColDecimalScale(ColIndex) Then
                ColDecimalScale(ColIndex) = DecimalScale
            End If

        End If

        Return SuggestedDataType

    End Function

End Class
