20180109; User cannot download software from SCCM software center, error code: 0x800705B4: 

Search error code from Bing, the code means "This operation returned because the timeout period expired". Check with user computer's log, path "C:\Windows\CCM\Logs\DataTransferService.log", it shows some error

> Error sending DAV request. HTTP code 500, status 'Internal Server Error'

According to the website https://www.anoopcnair.com/sccm-configmgr-default-iis-configurations-troubleshooting-issues/, all IIS setting was correct in (The SCCM DP for the user's client) , but when RDP to that DP and visit 

http://localhost/SMS_DP_SMSPKG$/DataLib 

http://localhost/SMS_DP_SMSPKG$/FileLib 

or http://localhost/SMS_DP_SMSPKG$/PkgLib 

It shows HTTP Error 500.19 – Internal Server Error, 

according to the website 
http://myitforum.com/myitforumwp/2014/01/15/http-error-500-19-internal-server-error-sccm-2012-sp1-windows-server-2012-wsus-x64/, 
review the ApplicationHost.config (locate it in under C:\windows\inetsrv\config), it's true that had the lines:
```
<scheme name=”xpress” doStaticCompression=”false” doDynamicCompression=”true”
 dll=”C:\Windows\system32\inetsrv\suscomp.dll” staticCompressionLevel=”10″
 dynamicCompressionLevel=”0″ />
```
Run the command line:

>%windir%\system32\inetsrv\appcmd.exe set config -section:system.webServer/httpCompression /-[name=’xpress’]

To disable the suscomp.dll which is being installed by the WSUS. The compression schemes are defined globally and loaded in every application Pool. when WSUS x64 register this dll it will result this error when x64 version of suscomp.dll attempts to load in an application pool which is running in x32 mode. Problem fixed.
