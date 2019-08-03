20170920; Manaully sync on-premise staffs to cloud:

> 1. Prefix condition: own "ADSyncAdmins" (group) permission and  “Administrators” (group) permisiion; 
> 2. Open PowerShell with administrator permission, run command: 
```powershell
Start-ADSyncSyncCycle -PolicyType delta
```
