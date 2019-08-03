20170327; HR need all user add to their location mail group automatically:

Create the dynamic distribution group and add the rules, done by powershell, remote logon app-fuobgadm01, open exchange management shell: 

```powershell
New-DynamicDistributionGroup -Name "Users@Company_CN_FS_DDG" -DomainController "inf-fuo01.company.com.cn" -OrganizationalUnit "company.com.cn/Groups" -RecipientContainer "company.com.cn" -RecipientFilter {RecipientType -eq "UserMailbox" -and City -eq "Foshan, Chan Cheng" -and HiddenFromAddressListsEnabled -eq $false} 
```
