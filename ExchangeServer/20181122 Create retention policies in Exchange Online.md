20181122; Create retention policies in Exchange Online:

Before create retention policies, need to create retention tags first, go to o365 Exchange Admin Center > compliance management > retention tags, create retention tags, then > retention policies, create retention policies. 

Check retention tags detail by PowerShell:
```powershell
Get-RetentionPolicyTag | Where-Object {$_.Name -like "*"} | fl
```
