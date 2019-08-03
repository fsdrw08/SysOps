20180724; Windows 10 workplace join:
```
dsregcmd.exe /status /debug
dsregcmd.exe /debug /leave 
```
Then restart. Other commands:
```
dsregcmd.exe /debug /join
C:\PSTools\PsExec.exe -i -d -s C:\WINDOWS\system32\dsregcmd.exe /debug /join 
```
