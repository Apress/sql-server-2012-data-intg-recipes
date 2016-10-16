using System;
using Microsoft.SqlServer.Server;
using System.Data.Sql;
using System.Data.SqlTypes;
using System.Text.RegularExpressions;


namespace Adama
{
public class RegexProfiling
{
[SqlFunction(IsDeterministic = true, IsPrecise = true)]
public static object PatternProfiler(string charInput)
{
string patternOutput = null;
System.Text.RegularExpressions.Regex regexTxt = new System.Text.RegularExpressions.Regex("[A-Z]", RegexOptions.IgnoreCase);
System.Text.RegularExpressions.Regex regexNum = new System.Text.RegularExpressions.Regex("[0-9]");
patternOutput = charInput;
patternOutput = regexTxt.Replace(patternOutput, "X");
patternOutput = regexNum.Replace(patternOutput, "N");
return patternOutput;
}
}
}