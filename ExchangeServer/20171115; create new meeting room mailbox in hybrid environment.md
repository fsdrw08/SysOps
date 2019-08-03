20171115; create new meeting room mailbox with auto process status:
1. Create resource mailbox from on premise exchange server (https://sync.company.com/ecp/), OU: 

2. Check mailbox automate processing on premise exchange server:
```powershell
Get-CalendarProcessing -identity KR-MeetingRoom-Seoul1@company.com -domaincontroller inf-xxx.company.emea
```

3. Check UPN suffix if "company.com", set attribute to trigger migrate action of mailbox to Office 365;

4. Add user permission to these mailboxes, run PowerShell command: 
```powershell
Add-MailboxFolderPermission KR-MeetingRoom-Seoul1@COMPANY.COM:\Calendar -User xxx -AccessRight Author 
```

5. Set mailbox auto process properties to show subject in outlook calendar, run PowerShell command:
```powershell
Set-CalendarProcessing -Identity KR-MeetingRoom-Seoul1@company.com -AddOrganizerToSubject $true 
```

6. Check mailbox permission, run PowerShell command:
```powershell
Get-MailboxFolderPermission KR-MeetingRoom-Seoul1@COMPANY.COM:\Calendar
Get-CalendarProcessing -identity KR-MeetingRoom-Seoul1@company.com
```
http://msexchangeguru.com/2014/07/07/add-mailboxfolderpermission/
