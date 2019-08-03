20170523; HR needs to know how many and whom of the staffs do not have email encryption certificates:
```powershell
$csv = Import-Csv "C:\Temp\20170523_Namelist_check_certificate.csv"
foreach ($LINE in $csv){
$EmployeeNumber = $LINE.EmployeeNumber
#Select Name, SamAccountName, EmployeeNumber, EmployeeID, EmailAddress, Certificates | 
Get-ADUser -Filter {EmployeeNumber -eq $EmployeeNumber} -Properties Name, SamAccountName, EmployeeNumber, EmployeeID, EmailAddress,Certificates | 
Select Name, SamAccountName, EmployeeNumber, EmployeeID, EmailAddress, @{n="Certificates";e={[string]$_.Certificates}} | 
Export-csv "C:\Temp\20170523_export_userscertificate.csv" -Append
} 
```
