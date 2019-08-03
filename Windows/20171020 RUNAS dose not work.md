20171020; User cannot remote login to FUO-HYPERV02, prompt "The user Profile Service service failed the logon. User profile cannot be loaded", but some old account which add in few months ago can login:

https://chentiangemalc.wordpress.com/2011/07/18/case-of-the-user-service-service-failed-the-logon/

1. Do a test to check new add account by existing account in this computer: Remote login to FUO-HYPERV02 by local administrator account(existing account), open CMD, run the command: 
> runas /user:company.com.cn\xxx.wu cmd

The account "company.com.cn\xxx.wu" is new for FUO-HYPERV02, after input the new account's password, CMD window shows: 

> RUNAS  ERROR: Unable to run - cmd
> 299: Only part of ReadProcessMemory or WriteProcessMemory request was completed.

This matched an Application Event log error.

2. Open ProcMon (download from http://live.sysinternals.com/ProcMon.exe). Filter set to filter any events with a result of ACCESS DENIED. With ProcMon running, repeated the RunAs command. Interestingly saw some "sqm" files located in the default user profile: C:\Users\Default\AppData\Local\Microsoft\VSCommon\14.0\SQM, go to the path and delete them, done.
