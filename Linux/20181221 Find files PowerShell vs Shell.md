20181221; Find files:

• PowerShell
(https://blogs.technet.microsoft.com/heyscriptingguy/2016/06/27/use-windows-powershell-to-search-for-files/)

For Windows:
```powershell
Get-ChildItem -Path C:\Users -Include *.pfx -Recurse -ErrorAction SilentlyContinue
```

For Linux, the -Include and -Recurse switch will issue a dead loop bug with "/" Path: 
(https://github.com/PowerShell/PowerShell/issues/3761)
```powershell
Get-ChildItem -Path / sources.list -Recurse -ErrorAction SilentlyContinue
```

• Shell
(https://www.wikihow.com/Find-a-File-in-Linux):
```shell
sudo -s
sudo find / -iname "filename" 
```
