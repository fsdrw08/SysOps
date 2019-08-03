20180927; a shared mailbox  create from Exchange Online, it cannot interactive with the user group which stay in On Premise exchange server:
https://support.microsoft.com/en-us/help/3129334/users-in-a-hybrid-deployment-can-t-access-a-shared-mailbox-that-was-cr

1. Convert the shared mailbox to a regular mailbox by using the Exchange admin center in Exchange Online. To do this, follow these steps: 

a. Open the Exchange admin center in Exchange Online.

b. Click recipients, and then click shared.

c. Select the shared mailbox, and then click Convert.

d. On the Warning page, select Yes to convert the shared mailbox.
        
2. Create an on-premises object for the cloud mailbox by using the New-RemoteMailbox cmdlet in the Exchange Management Shell:

a. Connect to on-premises Exchange Management Shell:
```powershell
$UserCredential = Get-Credential "company\admin"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://app-azr.company.com/PowerShell/ -Authentication Kerberos -Credential $UserCredential
Import-PSSession $session
```

b. Create an on-premises object for the cloud mailbox by using the New-RemoteMailbox cmdlet:
```powershell
$UserCredentials = Get-Credential
New-RemoteMailbox -Name "" -Password $UserCredentials.Password -UserPrincipalName xxx.com -OnPremisesOrganizationalUnit "" -Archive 
```

3. Set the ExchangeGuid property on the new on-premises object that you created in step 2 to match the cloud mailbox. To do this, follow these steps: 
                
a. Connect to Exchange Online by using a remote session of Windows PowerShell:
```powershell
$UserCredential = Get-Credential admin@company365.onmicrosoft.com"
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $UserCredential -Authentication Basic -AllowRedirection
Import-PSSession $Session 
```
b. Use the Get-Mailbox cmdlet to retrieve the value of the ExchangeGuid property of the cloud mailbox: 
```powershell
Get-Mailbox xxx | FL ExchangeGuid
```
> ExchangeGuid : yyy 
                
c. Open the Exchange Management Shell on the on-premises Exchange server.(Step 2a.)
                
d. Use the Set-RemoteMailbox cmdlet to set the value of the ExchangeGuid property on the on-premises object to the value that you retrieved in step 3b: 
```powershell
Set-RemoteMailbox xxx -ExchangeGuid yyy
```
4. Wait for directory synchronization to occur. Or, force directory synchronization.

5. Make sure that the Office 365 user object is displayed as "Synced with Active Directory."

6. Move the mailbox from Exchange Online to the on-premises environment.

7. Convert the mailbox to a shared mailbox by using the Set-Mailbox cmdlet in the Exchange Management Shell: 
```powershell
Set-Mailbox xxx.com -Type Shared 
```
8. Move the mailbox from the on-premises environment to Exchange Online.

