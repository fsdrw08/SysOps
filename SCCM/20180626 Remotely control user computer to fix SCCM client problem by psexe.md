20180626; Remotely control user computer to fix SCCM client problem by psexec:

Download PsTools: https://docs.microsoft.com/en-us/sysinternals/downloads/pstools

1. Run CMD as admin account:

> C:\Windows\System32\runas.exe /user:domain\admin  /savecred "%windir%\system32\cmd.exe"

    
2. In the CMD window, run psexec command, to remote connect target computer by target computer's admin account:

> Path\PSTools\psexec \\TargetComputer -u domain\admin -p password cmd

Change local admin password:
  
> net user administrator xxx

3. To locate sccm client problems:

  a. Check firewall status:
  
> netsh advfirewall show allprofiles state
  
  If domain firewall is on, turn it off:
 
> netsh advfirewall set domainprofile state off 

b. Check registry:

> REG QUERY HKLM\SOFTWARE\Microsoft\CCM\CcmExec /s 

If value "ProvisioningMode" is true, then set it off, 

if "SystemTaskExcludes" is not empty, make it empty:
```
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CCM\CcmExec /v ProvisioningMode /t REG_SZ /d false /f
REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CCM\CcmExec /v SystemTaskExcludes /t REG_SZ /d "" /f 
```

c. Check registry:

> REG QUERY HKLM\SOFTWARE\Microsoft\CCMSetup /s 

If value "LastValidMP" is old MP, it needs to uninstall SCCM client from user computer(https://www.arnavsharma.net/system-centre--more/deleting-sccm-client-manually):

> c:\windows\ccmsetup\ccmsetup.exe /uninstall 

Delete SCCM relative  folder:
```
rd /s /q "c:\windows\ccmsetup"
rd /s /q "c:\windows\ccm"
rd /s /q "c:\windows\ccmcache"
```

Delete SCCM relative registry key:
```
powershell -command "Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\CCM' -Recurse"
powershell -command "Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\CCMSetup' -Recurse"
powershell -command "Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\SMS' -Recurse" 
```
Remove WMI name space:
```
powershell -command "get-wmiobject -query \"SELECT * FROM __Namespace WHERE Name='CCM'\" -Namespace 'root' | Remove-WmiObject"
powershell -command "get-wmiobject -query \"SELECT * FROM __Namespace WHERE Name='sms'\" -Namespace 'root\cimv2' | Remove-WmiObject"
```
Then push SCCM client from SCCM console, if still failed to install SCCM client, rebuild the WMI, paste following commands to notepad, save as bat, run it in target computer, and reinstall SCCM client again:
```
@echo off
sc config winmgmt start= disabled
net stop winmgmt /y
%systemdrive%
cd %windir%\system32\wbem
Rename repository Repository.old
regsvr32 /s %SystemRoot%\system32\scecli.dll 
regsvr32 /s %SystemRoot%\system32\userenv.dll 
For /f %%s in ('dir /b *.dll') do regsvr32 /s %%s
wmiprvse /regserver
winmgmt /regserver
net start winmgmt
for /f %%s in ('dir /b *.mof *.mfl') do mofcomp %%s
pause 
```
