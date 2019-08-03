20180109; She needs to delete he - a resigned user's meeting which already accept by other people, plan to gain she owner permission to he's calendar folder: 

• Issue: 
Let she edit those meetings, but when run PowerShell command 
```powershell
Get-MailboxFolderPermission he@COMPANY.Com:\calendar 
```
to check Peng, he's  calendar permission, it shows 
*The operation couldn't be performed because 'he@COMPANY.Com:\calendar' couldn't be found.*

• Solution :

This mailbox have non English folder names, to check the calendar folder name
```powershell
Get-MailboxFolderStatistics he@company.com -FolderScope calendar 
```
Return the result:
*Name                              : 日历*

So, run this PowerShell script to gain calendar permission
```powershell
Add-MailboxFolderPermission he@COMPANY.COM:\日历 -User she@company.com -AccessRight Owner 
```
