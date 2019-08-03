20170921; Exchange 2007 server decommission:

1. Make sure all server which to decommission are empty, 
Migrate all mailbox to other site exchange server (Munich Exchange 2013 server), run PS script on Exchange 2013 server EXC-MCH13-DB01 to filter which mailbox still in FUO Exchange server: 
Getting all Databases:
```powershell
$databases = Get-MailboxDatabase -IncludePreExchange2013
```
Getting all Mailboxes from servers in Foshan based on the previous list:
```powershell
$mailboxes = $databases | where {$_.server -like "*fuo*"} | %{Get-Mailbox -Database $_}
```
Select the required attributes and export to CSV:
```powershell
$mailboxes  | select primarysmtpaddress,identity,samaccountname,userprincipalname,database | Export-Csv -Encoding "UTF8" -Delimiter "," -Path export.csv 
```

2. Copy whole "primarysmtpaddress" column to a new CSV file, with a new head column name "emailaddress". Login https://sync.company.com/ecp > recipients > migration > "+" > Move to a different database > Specify the users with a CSV file > Browse > select that new CSV file > next > New migration batch name > Move the primary mailbox and archive mailbox if one exists > Target database: EMEA_DB01 > …
3. After synced successfully show in https://sync.company.com/ecp > recipients > migration, select the Batch which create above, click complete in the right side.
4. Uninstall exchange software from the server, uncheck the role of the server, after uninstall, if the server configuration still exist in the exchange configuration list, go to ADSI > Configuration\CN=Configuration, DC=company, DC=net\CN=Services\CN=Microsoft Exchange\CN=company\CN=Administrative Groups\CN=Exchange Administrative Group\CN=Servers\ > check with the Exchange server which need to decommission, if exist, manually delete it.
5. Disconnect the Exchange server with the domain.
