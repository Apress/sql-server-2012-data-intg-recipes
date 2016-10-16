Set objBL = CreateObject("SQLXMLBulkLoad.SQLXMLBulkload.4.0")
objBL.ConnectionString = "provider = SQLOLEDB;data source = MySQLServer;database = CarSales_Staging; integrated security = SSPI"
objBL.ErrorLogFile = "C:\SQL2012DIRecipes\CH03\SQLXMLBulkLoadImporterror.log"
objBL.Execute "C:\SQL2012DIRecipes\CH03\SQLXMLBulkLoadImport_Simple.xsd", "C:\SQL2012DIRecipes\CH03\Clients_Simple.xml"
Set objBL = Nothing