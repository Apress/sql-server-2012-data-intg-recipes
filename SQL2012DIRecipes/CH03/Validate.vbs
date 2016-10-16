Dim SchemaCache
Set SchemaCache = CreateObject("MSXML2.XMLSchemaCache.6.0")
SchemaCache.Add "", "C:\SQL2012DIRecipes\CH03\FlattenedOutput.Xsd"
Dim XMLDoc
Set XMLDoc = CreateObject("MSXML2.DOMDocument.6.0")
Set XMLDoc.schemas = SchemaCache
XMLDoc.async = False
XMLDoc.Load "C:\SQL2012DIRecipes\CH03\FlattenedOutput.xml"
If XMLDoc.parseError.errorCode <> 0 Then
wscript.quit 1
end if