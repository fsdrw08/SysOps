#Get-ACL
$path = @"
\\server1\tier1\tier2\tier3
\\server2\tier1\tier2\tier3
"@ -split "`r`n"

$path | ForEach-Object {
    $_
    (Get-Acl $_).Access
    ""
} | Format-Table -Wrap

#Set-ACL
$modifyPermissionGroup = "domain\GroupName"

$path | ForEach-Object {
    $ACL = Get-ACL -Path $_
    $accessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($modifyPermissionGroup,"modify","ContainerInherit,ObjectInherit","None","Allow")
    $ACL.SetAccessRule($accessRule)
    $ACL
}
