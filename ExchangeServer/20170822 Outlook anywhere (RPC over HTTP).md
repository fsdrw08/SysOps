20170822; Many people's outlook cannot connect to server after migrate their mailbox to exchange 2013:

For historic reasons, Outlook Anywhere is disabled for users that worked for company in the past. But the connection type from Outlook anywhere (RPC over HTTP) is the default connection type for Exchange 2013. 
Run below PS script in Exchange2013 Management Shell to check user's MapiBlockOutlookRpc status:
```powershell
$csv = Import-Csv "C:\Temp\20170822_Import_BlockOutlook.csv"
foreach ($LINE in $csv) {
$EmailAddress = $LINE.EmailAddress
Get-CASMailBox $EmailAddress -DomainController INF-FUO01 |Select-Object Identity, MAPIBlockOutlookRpcHttp |
Export-Csv "C:\Temp\20170822_Export_BlockOutlook.csv" -Append
} 
```
Run below PS script to fix user's MapiBlockOutlookRpc status in batch:
```powershell
$csv = Import-Csv "C:\Temp\20170822_Import_BlockOutlook.csv"
foreach ($LINE in $csv) {
$EmailAddress = $LINE.EmailAddress
Set-CASMailBox $EmailAddress -DomainController INF-FUO01 -MAPIBlockOutlookRpcHttp $False
} 
```
