20180516; User report that they cannot install PC systems via PXE boot, when PXE boot, it shows
```
GATEWAY IP: XXX.XXX.XXX.XXX
TFTP..
PXE-M0F: Exiting Intel Boot Agent.
Selected boot device fail….
```
It means TFTP download failed:
• Background: 
WDS PXE boot procedure:
```
1. Client → DHCP Request → DHCP server: The client broadcast a request for an available IP address.
2. Client ← DHCP Reply ← DHCP server: The nearest DHCP server responds with an address. There reply includes "Option 66", "Option 67", which tells the client that the PXE server IP address and the boot file name.
3. Client → PXE Request → PXE server: The client requests the name of a boot image.
4. Client ← PEX Reply ← PXE server: The PXE server responds with a boot image filename.
5. Client → TFTP Request → PXE server: The client request the boot image file.
6. Client ← TFTP Reply ← PXE server: The server sends the boot image file to the client.
```
https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732351(v=ws.10)

TFTP download failed, need to check with the DHCP optional configuration and SCCM DP server.

• Solution: 

Open DHCP console with admin account, connect Shenzhen DHCP server FILE-SZX01.company.com.cn, check server options, to verify the setting of option 066 and 067, the options 067 value is "\SMSBoot\x86\wdsbp.com", it's different from other DHCP server setting, to verify it, open the SCCM Shenzhen DP path \\App-szxsccm02.company.com.cn\reminst\SMSBoot\x86, there is no "wdsbp.com" file here, just "wdsnpb.com" files, means that the value of option 067 in DHCP server FILE-SZX01.company.com.cn is wrong, change it to "\SMSBoot\x86\wdsnbp.com", done.
