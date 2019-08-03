20171103; Use PowerShell manage Exchange Online:

• Run PowerShell as Administrator
```powershell
Set-ExecutionPolicy RemoteSigned
$UserCredential = Get-Credential
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session 
```
• Or create a notepad with command in C:\Scripts\:
```powershell
$UserCredential = Get-Credential "admincn@xxx.onmicrosoft.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $session 
```        
Save the file with a .PS1 file extension, and create a shortcut for this PS1 file, input the shortcut path:

> powershell.exe -noexit C:\Scripts\ExchangeOnline.ps1 

