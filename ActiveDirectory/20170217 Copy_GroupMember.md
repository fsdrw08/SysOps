20170217; The employees who migrate from Old Domain to New Domain, been created new AD account from GHR, need to copy the access right from their old AD account:
```powershell
Import-Module ActiveDirectory
$csv = Import-Csv "C:\Temp\20170217_Copy_ACL.csv"
foreach ($LINE in $csv) 
{
 $OldUser = $LINE.old
 $NewUser = $LINE.SamAccountName
 Get-ADUser -Identity $OldUser -Properties memberof | Select-Object -ExpandProperty memberof |
 Add-ADGroupMember -Members $NewUser -server inf-fuo01.oldCompany.com.cn
} 
```
