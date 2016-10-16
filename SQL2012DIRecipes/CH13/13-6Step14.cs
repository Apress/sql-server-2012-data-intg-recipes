public void Main()
{
DataTable dT = new DataTable();
DataRow[] matchingRows;
String fileName = "";
Variables vars = null;
Variables varsMax = null;
PollLabel:
try
{
Dts.VariableDispenser.LockOneForWrite("User::RecordSet", ref vars);
dT = (DataTable)vars[0].Value;
matchingRows = dT.Select("IsProcessed = 0", "IndexID ASC");
int numberOfRows = matchingRows.GetLength(0);
if (numberOfRows != 0)
{
fileName = matchingRows[0][1].ToString();
matchingRows[0]["IsProcessed"] = true;
Dts.Variables["FileName0"].Value = fileName;
vars[0].Value = dT;
}
else
{
Dts.VariableDispenser.LockOneForRead("User::MaxFiles", ref varsMax);
Dts.Variables["Counter0"].Value = varsMax[0].Value;
}
vars.Unlock();
}
catch
{
System.Random RandomNumber = new System.Random();
Thread.Sleep(RandomNumber.Next(200, 800));
goto PollLabel;
}
Dts.TaskResult = (int)ScriptResults.Success;
}