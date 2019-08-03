20181114; Get-MailboxFolder didn’t work for other people:

Because of this cmdlet was designed for user to self-check only
(https://blogs.technet.microsoft.com/ilvancri/2010/08/20/get-mailboxfolder-is-not-working-exchange-web-servicesgetting-started/)

For walkaround, use other cmdlet combination:
https://serverfault.com/questions/690044/how-do-i-enable-get-mailboxfolder-to-work-against-other-mailboxes
```powershell
Get-Mailbox -Identity xxx | Select-Object alias | `
Foreach-Object {Get-MailboxFolderStatistics -Identity $_.alias | `
Select-Object Identity, ItemsInFolder, FolderSize, FolderAndSubfolderSize } 
```
