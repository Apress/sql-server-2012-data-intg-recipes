public void Main()
{
// Create dataset to hold file names
DataSet ds = new DataSet("ds");
DataTable dt = ds.Tables.Add("FileList");
DataColumn IndexID = new DataColumn("IndexID", typeof(System.Int32));
dt.Columns.Add(IndexID);
DataColumn FileName = new DataColumn("FileName", typeof(string));
dt.Columns.Add(FileName);
DataColumn IsProcessed = new DataColumn("IsProcessed", typeof(Boolean));
dt.Columns.Add(IsProcessed);
// create primary key on IndexID field
IndexID.Unique = true;
DataColumn[] pK = new DataColumn[1];
pK[0] = IndexID;
dt.PrimaryKey = pK;
DirectoryInfo di = new DirectoryInfo(Dts.Variables["FilePath"].Value.ToString());
FileInfo[] filesToLoad = di.GetFiles(Dts.Variables["FileType"].Value.ToString());
DataRow rw = null;
Int32 MaxFiles = 0;
foreach (FileInfo fi in filesToLoad)
{
rw = dt.NewRow();
rw["IndexID"] = MaxFiles + 1;
rw["FileName"] = fi.Name;
rw["IsProcessed"] = 0;
dt.Rows.Add(rw);
MaxFiles += 1;
}
Dts.Variables["User::MaxFiles"].Value = MaxFiles;
Dts.Variables["User::RecordSet"].Value = dt;
Dts.TaskResult = (int)ScriptResults.Success;
}