20181119; Detect and remove local Administrators group member in conditions:

The Remove-LocalGroupmember cmdlet should run from elevated local administrator account:
```powershell
net localgroup administrators |`
Where-Object {$_ -and $_ -notlike '*Admin*' -and $_ -notmatch 'command completed successfully'} | `
Select-Object -skip 2 | `
Remove-LocalGroupMember -Group 'Administrators'
```
https://powershell.org/2013/04/get-local-admin-group-members-in-a-new-old-way-3/
