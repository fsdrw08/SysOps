20170518; SCCM management console show that FUO-N00458 have no SCCM client install, SCCM client "Client certificate" shows "None":

> http://www.toolzz.com/?p=1278

Today we experienced issues during a Windows 7 deployment. The customer had SCCM 2012 R2 with a Windows 7 OSD and everything seemed to run perfect, except we had the following issues:

> - The SCCM client didn’t fully install – it remains in a Site Mode = Unknown 

> - The client certificate was not assigned

> - The _SMSTaskSequence folder created on C:\ was not removed

> - No client certificate installed

Cause:

Just a little bug.
During a ConfigMgr 2012 R2 OSD Task Sequence, the ConfigMgr client is purposely placed in a provisioning mode. In this mode, the ConfigMgr client does not pick up policy from the MP. This is done so that advertised programs, software updates, and tasks targeted to existing client PCs do not run until the Task Sequence completes. If advertised programs, software updates, or tasks attempt to run while the Task Sequence runs it may interfere with the Task Sequence and cause it to fail.
A Reboot step in the OSD Task Sequence is accidentally set to restart into the WinPE boot image assigned to the Task Sequence instead of the full Windows OS. This will cause the Task Sequence to end in WinPE. Because the ConfigMgr client is actually installed as part of the full Windows OS and not WinPE, and because the Task Sequence ends in WinPE instead of the full Windows OS, it cannot properly take the ConfigMgr client out of provisioning mode.

Solution:

Right after the “Setup Windows and ConfigMgr” step, add two “Run Command Lines” to set the registry values correctly. Here are the two commands to be run:
> REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CCM\CcmExec /v ProvisioningMode /t REG_SZ /d false /f
> REG ADD HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\CCM\CcmExec /v SystemTaskExcludes /t REG_SZ /d “” /f

This forced the client from going out of provisioning mode.
Problem was fixed!
