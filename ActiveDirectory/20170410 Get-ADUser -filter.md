20170410; HR needs to know how many and whom of the staffs have mobile phone number(who have mobile phone bill reimbursement):
```powershell
$searchBase = "Dc=Company, DC=COM, DC=CN"
Get-ADUser -Filter {MobilePhone -ne "$null" -and EmployeeNumber -like "2800*" -and Enabled -eq $True} -SearchBase $searchBase -Properties MobilePhone, EmployeeNumber, EmailAddress |
Select Name, SamAccountName, EmployeeNumber, MobilePhone, EmailAddress|
Export-csv "C:\Temp\20170405_export_mobileusers5.csv" -Append
```
