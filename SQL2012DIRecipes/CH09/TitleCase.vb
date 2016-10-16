using System;
using System.Data;
using System.Collections;
using System.Data.SqlTypes;
using System.Data.SqlClient;
using Microsoft.SqlServer.Server;
using System.Globalization;
public partial class UserDefinedFunctions
{
[Microsoft.SqlServer.Server.SqlFunction(IsDeterministic = true, IsPrecise = true)]
public static SqlString FncProperCase(string inputData)
{
System.Globalization.CultureInfo cultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
TextInfo textInfo = cultureInfo.TextInfo;
inputData = textInfo.ToTitleCase(inputData);
return new SqlString(inputData);
}
};