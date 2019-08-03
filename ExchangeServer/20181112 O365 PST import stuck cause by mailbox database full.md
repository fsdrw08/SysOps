20181112; 3 users failed to import PST from O365 admin portal, the import job shows “Source file found. Import into Exchange in progress”, download the log, it shows error "MRSUnknow" :

• Investigation: 

Check mailbox import request with Exchange Online PowerShell
```powershell
Foreach ($User in "1","2","3")
{
Get-MailboxImportRequest -Mailbox $user | Get-MailboxImportRequestStatistics -IncludeReport | Export-Csv D:\temp\requestdetail.csv -Append -NoTypeInformation
} 
```
Or
```powershell
Get-MailboxImportRequest 1 | Where-Object {$_.Status -like "Failed"} | Get-MailboxImportRequestStatistics | fl RequestGuid,message 
```

The message column shows following error message:
```
Error: Target database 'EURPR02DG246-db115' cannot be used:
Database is excluded from provisioning: 'True'.
```

It means that there are some problems in this database, for more information about Exclude a Mailbox Database from Provisioning: 

http://techgenix.com/ExcludeaMailboxDatabasefromProvisioning/

But there is no "Set-MailboxDatabase" cmdlet to change the mailbox database settings in Exchange Online scenario.


• Solution:
  1. Move users' mailbox to other mailbox database (move the user mailbox database also can fix most of the mailbox cases in exchange online ):
```powershell
Foreach ($User in "1","2","3"){
  New-MoveRequest -Identity $User
}
```

  2. Check move request:
```powershell        
Get-MoveRequest | Where-Object {($_.DisplayName -like "*1*") -or ($_.DisplayName -like "*2*") -or ($_.DisplayName -like "*3*")} | Get-MoveRequestStatistics -IncludeReport | fl 
```

  3. If move failed(suspend): 
```powershell
Resume-MoveRequest UserName
```

  4. After mailbox move complete, go to O365 admin portal > Security & Compliance > Data government > Import (https://protection.office.com/#/import), manually re-create an PST import job, then check the mailbox import status
  ```powershell
Get-MailboxImportRequest -Status Queued
Get-MailboxImportRequest -Status InProgress
```
Shows that the user who previous import failed now the import are in progress.
