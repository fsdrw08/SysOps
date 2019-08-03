20171215; Create Storage Pool by PowerShell:
```powershell
$PhysicalDisks = Get-PhysicalDisk -CanPool $True
#Get-StorageSubSystem and mark down the FriendlyName
New-StoragePool -FriendlyName HP-Z230-1-Pool -StorageSubsystemFriendlyName "xxx" -PhysicalDisks $PhysicalDisks
$Physicaldisk = Get-PhysicalDisk -FriendlyName "SAMSUNG SSD PM851 mSATA 128GB"
Add-PhysicalDisk -StoragePoolFriendlyName HP-Z230-1-Pool -PhysicalDisks $Physicaldisk
Get-StoragePool -FriendlyName HP-Z230-1Pool | Get-PhysicalDisk
New-VirtualDisk -StoragePoolFriendlyName "HP-Z230-1-Pool" -FriendlyName Virtualization -ResiliencySettingName Mirror -Size 100GB -ProvisioningType Thin 
```
