SELECT ID, NameType, UPV.CliName
FROM CarSales_Staging.dbo.ClientList
UNPIVOT (CliName FOR NameType in (PrimaryContact, SecondaryContact,
ThirdContact)) as UPV;