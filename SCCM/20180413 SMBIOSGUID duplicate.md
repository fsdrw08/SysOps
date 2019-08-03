20180413; User report that he cannot install one machine via PXE boot, prompt "PXE boot abort", computer MAC address: A0:48:1C:DF:D9:11, PXE boot IP: x.x.x.x:

Go to this server with the PXE boot IP , to check the PXE boot log from the path: "F:\SMS_DP$\sms\logs\SMSPXE.log", the log said
> A0:48:1C:DF:D9:11, C811F614-7352-11E3-9B7A-B3CD810700F4: no advertisements found	SMSPXE	4/13/2018 1:58:12 PM	6008 (0x1778)

It means nothing to do according to SCCM. But this computer object had been added to the install collection. Need to check if "some other record" has the same SMBIOSGUID, because SCCM always take SMBIOSGUID first. 

To check the SMBIOSGUID, go to SCCM console "\Monitoring\Overview\Queries\Administration\find SMBIOSGUID" , search the SMBIOSGUID "C811F614-7352-11E3-9B7A-B3CD810700F4", found another computer, delete this computer, problem fix.
