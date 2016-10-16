bcp CarSales.dbo.Client OUT C:\SQL2012DIRecipes\CH07\aa1.txt -SAdam_01\Adam –c -T


bcp "SELECT ID,ClientName FROM CarSales.dbo.Client" QUERYOUT C:\SQL2012DIRecipes\CH07\aa1.txt -SAdam_01\Adam –c -T


bcp "EXECUTE CarSales.dbo.pr_OutputClients" QUERYOUT C:\SQL2012DIRecipes\CH07\aa1.txt -SAdam_01\Adam –c -T

SELECTID, + '"' + ClientName + '"', Country
FROM CarSales.dbo.Client;



