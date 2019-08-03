20181025; Remove local Outlook PST files:

https://gallery.technet.microsoft.com/office/5e7b464d-fb81-4fa1-9b8b-50bc6f02d175#content

https://www.experts-exchange.com/questions/29002695/Outlook-Remotely-disconnecting-a-PST-with-Powershell.html
```powershell
$Outlook = new-object -COMObject outlook.application
 
$PSTs = $Outlook.Session.Stores | where { ($_.FilePath -like '*.PST') } 
# | format-table DisplayName, FilePath -autosize
 
$NameSpace = $Outlook.GetNameSpace("MAPI")
 
#$PSTs = "C:\Users\xxx\Documents\Outlook Files\TEST.pst"
 
foreach ($PST in $PSTs){
#$PST = $NameSpace.Stores | ? {$_.FilePath -eq $PSTs}
$PSTRoot = $PST.GetRootFolder()
$PSTFolder = $namespace.Folders.Item($PSTRoot.Name)
$NameSpace.GetType().InvokeMember('RemoveStore',[System.Reflection.BindingFlags]::InvokeMethod,$null,$namespace,($PSTFolder))
} 
```
