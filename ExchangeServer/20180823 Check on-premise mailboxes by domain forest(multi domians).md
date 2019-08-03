20180823; Check on-premise mailboxes by domain forest:

```powershell
Get-Mailbox -IgnoreDefaultScope | Measure-Object
Get-Mailbox -IgnoreDefaultScope -RecipientTypeDetails usermailbox -database emea_db01 | measure-object 
Get-Mailbox -IgnoreDefaultScope -database emea_db01 
$Mailbox = Get-Recipient -IgnoreDefaultScope -database emea_db01 | select Alias
 
ForEach ($LINE in $Mailbox){
   $Alias = $LINE.Alias
#  https://powershell.org/forums/topic/using-set-aduser-to-change-an-ad-account-outside-current-forest/
   $User = Get-ADObject -Filter {mailNickname -eq $Alias} -Properties CanonicalName -Server "inf-fuodc01.int.company.com:3268"
   $UserOU = $User.CanonicalName
   $Userpos = $UserOU.IndexOf("/")
   $UserSrv = $UserOU.Substring(0, $Userpos)
   $Recipient = Get-Recipient -IgnoreDefaultScope -Identity $User.DistinguishedName | Select Name,Database,RecipientTypeDetails
   $Statistics = Get-MailboxStatistics $User.DistinguishedName | Select LastLogonTime
   Get-ADUser $User -server $UserSrv -Properties enabled,CanonicalName,EmailAddress,Manager,WhenCreated,LastLogonTimeStamp | Select Name,Enabled,CanonicalName,EmailAddress,whencreated,`
@{n='Manager';e={$_.manager}},`
@{n="ADLastLogon";e={[DateTime]::FromFileTime($_.lastLogonTimestamp)}},@{n="Database";e={$Recipient.Database}},`
@{n="RecipientTypeDetails";e={$Recipient.RecipientTypeDetails}},@{n="MailboxLastLogon";e={$Statistics.LastlogonTime}}|
Export-csv "C:\Temp\20180830_export_EMEA_DB01ExcUsers.csv" -Append -notypeinformation
}

Get-Mailbox -Resultsize Unlimited | Where-Object {$_.GrantSendOnBehalfTo} | select Name,@{Name='GrantSendOnBehalfTo';Expression={($_ | Select -ExpandProperty GrantSendOnBehalfTo | Select -ExpandProperty Name) -join ","}} | export-csv -notypeinformation c:\sendonbehalf.csv 
```
Found on Spiceworks: https://community.spiceworks.com/canonical_answer_pages/808-list-of-all-mailboxes-on-exchange-2010-sp1?utm_source=copy_paste&utm_campaign=growth
