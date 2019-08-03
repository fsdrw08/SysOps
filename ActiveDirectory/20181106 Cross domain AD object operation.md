20181106; HR needed to remove resigned users from Shenzhen user mail list:
Update the resigned user process PowerShell script:
```powershell
Function ArrayTo-String{
  param(
    $In
  )
        
  $Result = $null
  
  if($In){
    foreach($i in $In){
      $Result+= $i+"`r`n"
    }
    
    return $Result.Remove($Result.Length-1,1)
  }
  
  else{
    return $Result
  }
}
$Leavers = Get-ADUser -SearchBase "OU=Disabled_Users,OU=COMPANY_Disabled,DC=company,DC=com" -filter {Country -eq "CN"}  -Properties canonicalname,MemberOf
#$ResignUser = Get-ADObject -LDAPFilter:"(ANR=$User)" -server $Server -Properties canonicalname,MemberOf
Foreach ($ResignUser in $Leavers){
$Server = "dc.company.com:3268"
$ResignUserOU = $ResignUser.CanonicalName
$ResignUserpos = $ResignUserOU.IndexOf("/")
$ResignUserSrv = $ResignUserOU.Substring(0, $ResignUserpos)
#$ExpireDate = "Time"
$MemberOf = $ResignUser.MemberOf | Where {$_ -like "*DC=CN"} | Get-ADObject -Properties CanonicalName -Server $Server

$ResignUser | Set-ADUser -Replace @{info = (ArrayTo-String -in $MemberOf.name)} -PassThru -Server $ResignUserSrv
foreach ($Group in $MemberOf)
{
    $GroupOU = $Group.CanonicalName
    $Grouppos = $GroupOU.IndexOf("/")
    $GroupSrv = $GroupOU.Substring(0, $Grouppos)
    Set-ADObject -Identity $Group.DistinguishedName -Remove @{member=$ResignUser.DistinguishedName} -Server $GroupSrv
}
#Set-ADAccountExpiration -Identity $ResignUser -DateTime $ExpireDate
Set-ADObject -Identity $ResignUser -Clear manager -Server $ResignUserSrv
#Move-ADObject -Identity $ResignUser -TargetPath "OU=Disabled_Users,OU=COMPANY_Disabled,DC=company,DC=com" -Server $ResignUserSrv
#$ResignUser | Set-ADObject -Clear departmentNumber
}
