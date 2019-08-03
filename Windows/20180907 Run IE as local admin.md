20180907; Run IE as local admin:

• By CMD:

> C:\Windows\System32\runas.exe /user:Computer\Administrator /savecred "\"C:\Program Files (x86)\Internet Explorer\iexplore.exe\" about:blank" 

• By PowerShell:

```powershell
$adminuser = "company\admin"
$adminpass = "" | convertto-securestring -AsPlainText -Force
$admincred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $adminuser, $adminpass

Start-Process PowerShell -Credential $admincred -ArgumentList "Get-ADComputer computer -server inf-fuodc01.company.com -Properties ms-mcs-admpwd | Select-Object -ExpandProperty ms-mcs-admpwd | Out-File C:\Temp\password.txt" 


$user = ".\administrator"
$pass = Get-Content "C:\Temp\password.txt" | convertto-securestring -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $user, $pass

Start-Process -FilePath "C:\Program Files\internet explorer\iexplore.exe" -Credential $cred -ArgumentList "Https://www.icbc.com.cn" 
```
