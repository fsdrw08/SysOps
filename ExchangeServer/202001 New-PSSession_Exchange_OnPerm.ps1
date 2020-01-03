$adminCredential = Get-Credential
$excSrvUri = "http://exchangeServer.company.com/PowerShell/"
$excSession = New-PSSession -ConfigurationName Microsoft.Exchange `
                            -ConnectionUri $excSrvUri `
                            -Authentication Kerberos `
                            -Credential $adminCredential
Import-PSSession $excSession -DisableNameChecking

#uncomment below spin to remove ps session
#Get-PSSession | Remove-PSSession
