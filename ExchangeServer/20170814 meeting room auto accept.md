20170814; User reported that the meeting room #fs-meetingroom-Narcissus_B1F1 cannot auto accept meeting:
Run PowerShell command in APP-FUOBGAMD01 Exchange Management Shell: 
```powershell
get-mailboxcalendarsettings -identity xxxx@company.com -domaincontroller inf-fuo01.company.com.cn
<#
Identity                                                     AutomateProcessing
--------                                                     ------------------
company.com.cn/!FS/!Resource/#fs-meetingroom-xxx_B1F1    AutoUpdate
#>

set-mailboxcalendarsettings -identity xxxx@company.com -domaincontroller inf-fuo01.company.com.cn -automateprocessing:autoaccept 

get-mailboxcalendarsettings -identity xxx@company.com -domaincontroller inf-fuo01.company.com.cn 
<#
Identity                                                     AutomateProcessing
--------                                                     ------------------
company.com.cn/!FS/!Resource/#fs-meetingroom-xxx_B1F1    AutoAccept
#>
```
Done.
