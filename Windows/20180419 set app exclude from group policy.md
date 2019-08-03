20180419; User reports that after migration, she cannot not use the Windows app "sound recorder" any more:

After check, found that we cannot grant the privacy permission (Camera, Microphone etc.) to UWP app, which are blocked by group policy: 
Computer Configuration/Policies/Administrative Templates/Windows Components/App Privacy/Let Windows apps access…/Force Deny

Solution:
  1. Get the app PackageFamilyName, run PowerShell cmdlet:
        get-appxpackage | where {$_.name -like "*recorder*"} 
        Return the result:
```        
        Name              : Microsoft.WindowsSoundRecorder
        Publisher         : CN=Microsoft Corporation, O=Microsoft Corporation, L=Redmond, S=Washington, C=US
        Architecture      : X64
        ResourceId        :
        Version           : 10.1709.2703.1000
        PackageFullName   : Microsoft.WindowsSoundRecorder_10.1709.2703.1000_x64__8wekyb3d8bbwe
        InstallLocation   : C:\Program Files\WindowsApps\Microsoft.WindowsSoundRecorder_10.1709.2703.1000_x64__8wekyb3d8bbwe
        IsFramework       : False
        PackageFamilyName : Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe
        PublisherId       : 8wekyb3d8bbwe
        IsResourcePackage : False
        IsBundle          : False
        IsDevelopmentMode : False
        Dependencies      : {Microsoft.VCLibs.140.00_14.0.25426.0_x64__8wekyb3d8bbwe,
                            Microsoft.WindowsSoundRecorder_10.1709.2703.1000_neutral_split.language-zh-hans_8wekyb3d8bbwe,
                            Microsoft.WindowsSoundRecorder_10.1709.2703.1000_neutral_split.scale-125_8wekyb3d8bbwe}
        IsPartiallyStaged : False
```        
    Mark down the PackageFamilyName: 
>       Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe
  2. Go to Group Policy Management
    Computer Configuration/Policies/Administrative Templates/Windows Components/App Privacy/Let Windows apps access the microphone
        Input the voice recorder app PackageFamilyName "Microsoft.WindowsSoundRecorder_8wekyb3d8bbwe" to "Force allow these specific apps (use Package Family Names)".
  
  3. Remote control user's computer, cmd > gpupdate /force, problem fixed.
