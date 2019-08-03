20181114; Enable remote desktop:

• By CMD: 
Check Registry: 
```
REG QUERY "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections
```
If value shows 1: 
```
REG add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f
netsh advfirewall firewall set rule group="remote desktop" new enable=yes profile=domain
```
• By PowerShell: 
```powershell
$Path = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server"
$Name = "fDenyTSConnections"
$Value = 0
IF((Get-ItemProperty -Path $Path -Name $Name).$Name -ne $Value)
{
Set-ItemProperty -Path $Path -Name $Name -Value $Value
} 
netsh advfirewall firewall set rule group="remote desktop" new enable=yes profile=domain
```
