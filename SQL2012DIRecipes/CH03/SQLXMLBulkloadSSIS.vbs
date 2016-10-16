Set InputVars = Wscript.Arguments
XMLSource = InputVars.Item(0)
Set objBL = CreateObject("SQLXMLBulkLoad.SQLXMLBulkload.4.0")
objBL.ConnectionString = "provider = SQLOLEDB;data source = ADAM02;database=CarSales_Staging;Uid=Adam;Pwd=Me4B0ss"
objBL.ErrorLogFile="C:\SQL2012DIRecipes\CH03\SQLXMLBulkLoadImporterror.log"
objBL.Execute "C:\SQL2012DIRecipes\CH03\SQLXMLBulkLoadImportElementAndAttribute.xsd", XMLSource
Set objBL = Nothing