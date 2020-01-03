#import PowerShell ActiveDirectoroy Module from Domain Controller, so that manage AD object from local ps client

$userCredential = Get-Credential
$DC = "DomainController.company.com"
$DCSession = New-PSSession -ComputerName $DC -Credential $userCredential
Invoke-Command $DCSession -Scriptblock { Import-Module ActiveDirectory,DhcpServer }
Import-PSSession -Session $DCSession -module ActiveDirectory,DhcpServer

#Uncomment below spin to remove the session
#Get-PSSession | Remove-PSSession
