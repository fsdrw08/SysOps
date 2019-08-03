20181203; User report that he cannot enroll "COMPANY User Auto" certificate:

• Investigation:

  1. From user local client, go to %windir%\system32\certmgr.msc > right click "Certificates\Personal\Certificates" > All Tasks > Request New Certificate… > Next > Show all templates > the "COMPANY User Auto" item shows 
```
COMPANY User Auto                               STATUS: Unavailable
##The permissions on the certificate template do not allow the current user to enroll for this type of certificate. ##
##You do not have permission to request this type of certificate.##
```  
  2. Check "COMPANY User Auto" certificate from other client, note that this certificate is issued by CA “COMPANY AUTO Issuing CA 2015”
  
  3. Run %windir%\system32\certsrv.msc (Certificate Authority) as domain admin account, from , Action > Retarget Certificate Authority > Another computer > Browse > select "COMPANY AUTO Issuing CA 2015" > OK > Finish > right click "COMPANY AUTO Issuing CA 2015\Certificate Templates" > Manage > right click "COMPANY User Auto" > Properties > Security, find out that there are 2 groups be denyed to Enroll or Autoenroll in permissions: "COMPANY\ACL_All_Admins-World" and "COMPANY\ACL@Company-NoUserCert".
  
      Maybe next time we can try https://github.com/Crypt32/PSPKI
  
  4. Check user's all groups recursively by PowerShell 
  
  (https://practical-admin.com/blog/powershell-recursively-show-group-membership-for-an-active-directory-object/#comment-365212):
  ```powershell
  function Get-GroupsForObject {
            [cmdletbinding()]
            param(
                [string]$Object = "", 
                [int]$Level = 0,
                [string]$Server = ""
            )
         
            $indent = "-" * $Level
            
            $d = Get-ADObject -Identity $Object -Properties SamAccountName,CanonicalName -Server $Server
            $dOU = $d.CanonicalName
            $dPos = $dOU.IndexOf("/")
            $dSvr = $dOU.Substring(0, $dPos)
            
            if ($Level -eq 0) {
                #write-host "$indent# $($d.SamAccountName)" -ForegroundColor Red
            }
         
            if ($d.ObjectClass -eq "user" -and $Level -eq 0) {
                $e = Get-ADUser -Identity $d.DistinguishedName -Properties MemberOf,PrimaryGroup -Server $dSvr
         
                #Include primary group
                Get-GroupsForObject -Object (get-adgroup $e.primarygroup).distinguishedname -Level($Level + 1) -Server $Server
         
            } elseif ($d.ObjectClass -eq "group") {
                if ($Level -gt 0) {
                    #write-host "$indent> $($d.SamAccountName)"
                    New-Object PSObject -Property @{
                        Name = $($d.CanonicalName)
                        Level = $Level
                    }
                }
         
                $e = Get-ADGroup -Identity $d.DistinguishedName -Properties MemberOf -Server $dSvr
         
            }
         
            $e.MemberOf | Sort-Object | %{
                # prevent a loop if the group is a member of itself
                if ( $_ -ne $e.DistinguishedName ) {
                    Get-GroupsForObject -Object $_  -Level($Level + 1) -Server $Server
                }
            }
         
        }
         
        Get-GroupsForObject -Object (Get-ADUser xxx) -Server "INF.company.com:3268" | fl 
```
        Find out that there are 2 groups under COMPANY\ACL_All_Admins-World group.

• Sulotion:
        Remove those 2 groups.
