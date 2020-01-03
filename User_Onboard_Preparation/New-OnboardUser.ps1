#import PowerShell ActiveDirectoroy Module from Domain Controller, so that manage AD object from local ps client
$userCredential = Get-Credential
$DC = "DomainController.company.com"
$DCSession = New-PSSession -ComputerName $DC -Credential $userCredential
#$DCSession = Get-PSSession | Where-Object {$_.ComputerName -eq $DC}

#import Exchange module from exchange server, in oder to create new user mailbox
$excSrvUri = "http://excSrv.company.com/PowerShell"
$excSession = New-PSSession -ConfigurationName Microsoft.Exchange `
                            -ConnectionUri $excSrvUri`
                            -Authentication Kerberos -Credential $userCredential
Import-PSSession $excSession -DisableNameChecking


#define the CSV which contains onboard user data
$newUserCsv = "\\server\share\path\new.user.csv"

#Remote to the domain controller create user
Invoke-Command -Session $DCSession -ScriptBlock {
    Import-Csv -Path $using:newUserCsv `
        | ForEach-Object {
            $params = @{
                "instance" = (get-ADUser -Identity $_.Instance -Properties memberof,StreetAddress,`
                telephoneNumber,wWWHomePage,HomePage,Department,Company,office,co,facsimileTelephoneNumber,Fax)
                "samAccountName" = $_.samAccountName
                "userPrincipaName" = $_.upn
                "Title" = $_.title
                "path" = (Get-ADUser $_.Instance).DistinguishedName -replace '^cn=.+?(?<!\\),'
                "Name" = $_.DisplayName
                "DisplayName" = $_.DisplayName
                "GivenName" = $_.GivenName
                "SurName" = $_.SurName
                "AccountPassword" = ConvertTo-SecureString -String $_.password -AsPlainText -Force
                "Enable" = $true
                "ChangePasswordAtLogon" = $false
            }
            $params

            if (![bool](Get-ADUser -Filter { samAccountName -eq "$($_.samAccountName)"})) {
                New-ADUser @params
            }
        }
}

#Copy base memberof
Invoke-Command -Session $DCSession -ScriptBlock {
    Import-Csv -Path $using:newUserCsv `
        | ForEach-Object {
            $copyToUser = Get-ADUser $_.samAccountName -prop memberof

        (Get-ADUser $_.instance -prop MemberOf).MemberOf `
            | Where-Object { $copyToUser.MemberOf -notcontains $_ } `
            | Add-ADGroupMember -Member $copyToUser
        }
}

#Set home folder, add other memberof, enable mailbox
Import-Csv -Path $newUserCsv `
    | ForEach-Object {
        #set home folder
        $basePath = "\\server\homePath\localtion\"
        $sam = $_.samAccountName
        if (!(Test-Path $basePath$sam)) {
            New-Item -Path $basePath$sam -Name $sam -ItemType "directory"
        }
        $ACL = Get-Acl -Path $basePath$sam
        $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule("domain\$sam","FullControl","ContainerInHerit,ObjectInherit","Name","Allow")
        $ACL.SetAccessRule($accessRule)
        $ACL | Set-Acl -Path $basePath$sam
        Set-ADUser -Identity $sam -HomeDirectory $basePath$sam -HomeDrive "J:"

    #add other memberof
        $_.group -split ";" `
            | ForEach-Object {
                Add-ADGroupMember -Identity $_ -members $sam
            }

    #enable maiobox
        if (![bool](Get-Mailbox -filter { samAccount -eq $sam })) {
            Enable-Mailbox -Identity $sam -Alias $sam -DataBase $_.database
        }
    }
