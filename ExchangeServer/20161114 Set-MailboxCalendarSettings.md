20161114; User report that she cannot book a meeting room(B11F3's) successfully, the meeting room shows the meeting is tentative:

• ISSUE: There are many users cannot book the meeting room which in B11F3, the meeting room: "#FS-MEETINGROOM-XXX-B11F3" –like are created in the same period, open the meeting room calendar, hover the pointer on the meeting which they book, it shows "this meeting has not been accepted", it's the problem about msiing the meeting room auto accept setting, these meeting room mailbox havn't set auto accept before. 

• Solution: After creat a meetingroom, we should add IT group "Users@Company_IT_FS" into the full access permission, then login outlook/OWA by the meeting room account, Options > Resource Settings > Resource Scheduling Options > check the box of "Automatically process meeting requests and cancelations", done. Or run the command 
```powershell
Set-MailboxCalendarSettings -Identity "#fs-meetingroom-xxx-B11F3" -DomainController "inf-fuo01" -AutomateProcessing AutoAccept
```
On the Exchange Server power shell.
