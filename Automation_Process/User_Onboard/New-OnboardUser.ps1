$path = "$PSScriptRoot\user.csv"
Test-Path $path

$cred = Get-Credential
$DCName = ""
$ExcName = ""
$DCSession = New-PSSession -ComputerName $DCName -Credential $cred
New-PSSession -ComputerName $ExcName -Credential $cred
Invoke-Command -Computer $DCName {import-module ActiveDirectory}
Invoke-Command -Computer $ExcName {import-module Exchange}

 
#Get in to DC and run New-ADUser 
Invoke-Command -Session $DCSession -ScriptBlock {
  Import-Csv -Path $using:path | ForEach-Object {
  ""
    $instance = ($_.instance -split "`n")[0]
    $params = @{
      "Instance" = (Get-ADUser -Identity $instance -Properties memberof,StreetAddress,telephoneNumber,wWWHomePage,HomePage,Department,Company,office,co,facsimileTelephoneNumber,Fax)
      "samAccountName" = $_.samAccountName
      "UserPrincipalName" = $_.upn
      "Title" = $_.Title
      "Path" = (Get-ADUser $instance).DistinguishedName -replace '^cn=.+?(?<!\\),'
      "Name"=$_.DisplayName
      "DisplayName"=$_.DisplayName
      "GivenName"=$_.givenname
      "SurName"=$_.surname
      "AccountPassword"=  ConvertTo-SecureString -String $_.password -AsPlainText -Force
      "Enabled"=$true
      "ChangePasswordAtLogon"=$false
    }
    #$params
    #
    $SAM = $params['samAccountName']
    if (-not (Get-ADObject -Filter { SamAccountName -eq $SAM})) {
      $params
      #"to new " + $_.samaccountname
      New-ADUser @params -Confirm
    } else {
      $($_.samAccountName) + "already exist"
    }
  }
}
 
 
#Copy-BaseMemberOf
Invoke-Command -Session $DCSession -ScriptBlock {
  Import-Csv -Path $using:path | ForEach-Object {
    $CopyToUser = Get-ADUser $_.samAccountName -prop MemberOf
    $_.instance -split "`n" | ForEach-Object {
      (Get-ADUser $_ -prop MemberOf).MemberOf | Where-Object {$CopyToUser.MemberOf -notcontains $_} | Add-ADGroupMember -Member $CopyToUser #-WhatIf
      #Add-ADGroupMember -Identity $_ -Members $sam
    }
  }
}
 
 
#Set-HomeFolder & Add-OtherMemberOf & Enable-Mailbox
Import-Csv -Path $path | ForEach-Object {
  #Set home folder
  $basePath = "\\Storage\HomePath\Regin\"
  $sam = $_.samAccountName
  if (-not (Test-Path $basePath$sam)) {
    "Set $basePath$sam"
    New-Item -Path $basePath -Name $sam -ItemType "directory" -Confirm
  } else {
    "$basePath$sam already exist"
  }
  if (-not [bool]((get-acl "$basePath$sam").access | Where-Object {$_.IdentityReference -like "*$sam" -and $_.filesystemrights -eq "Fullcontrol"})) {
    $ACL = Get-Acl -Path $basePath$sam
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("company\$sam","FullControl","ContainerInherit,ObjectInherit","None","Allow")
    $ACL.SetAccessRule($accessRule)
    $ACL | Set-Acl -Path $basePath$sam
    Set-ADUser -Identity $sam -HomeDirectory $basePath$sam -HomeDrive "J:"
  } else {
    "$basePath$sam ACL had set"
  }
 
  #Add other memberof
  if ($_.group) {
    $_.group -split "`n" | ForEach-Object {
        Add-ADGroupMember -Identity $_ -Members $sam
    }
  }
 
  #Enable Mailbox
  if (![bool](Get-Recipient $sam -ErrorAction "SilentlyContinue")) {
    if ($_.database -ne "") {
      $sam+"@company.com"
      Enable-Mailbox -Identity $sam -Alias $sam -Database $_.database -Confirm
    }
    else {
      "fill out exchange database first"
    }
  } else {
    "$sam@company.com recipient already exist"
  }
}
 
 
Test-Path $basePath$sam
 
<#
#Enable-Mailbox
Import-Csv -Path $path | ForEach-Object {
  $sam = $_.samAccountName
  Enable-Mailbox -Identity $sam -Alias $sam -Database $_.database
}
#>
 
$baseNumber = "+12 234 567 890 Ext. "
#set user access card number & telephone number
Import-Csv -Path $path | ForEach-Object {
  if ($_.cardNo -or $_.telephonenumber) {
    if ($_.cardNo) {
        Set-ADUser $_.samAccountName -Replace @{'info' = $_.cardNo}
    }
    $telephoneNumber = $baseNumber + $_.telephonenumber
    Set-ADUser $_.SamAccountName -Replace @{telephonenumber=$telephonenumber}
  }
}
 
Import-Csv -Path $path | ForEach-Object {
  Get-ADUser $_.samAccountName -Properties telephonenumber,info | Select-Object samaccountname,telephonenumber,info
} | Format-Table