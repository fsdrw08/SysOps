20180308; migrate some users skype for business account to cloud:
Run by PowerShell
```powershell
Import-Module SkypeOnlineConnector
$creds = Get-credential "admin@company365.onmicrosoft.com"
ForEach ($User in "1","2","3")
{
Move-CsUser -Identity $User -Target sipfed.online.lync.com -Credential $creds -HostedMigrationOverrideUrl https://admin1e.online.lync.com/HostedMigration/hostedmigrationservice.svc -DomainController INF.INT.COMPANY.COM
}
```
