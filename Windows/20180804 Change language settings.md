20180804; Change language settings:
• Add a language
```powershell
$OldList = Get-WinUserLanguageList
$OldList.Add("zh-Hans-CN")
Set-WinUserLanguageList -LanguageList $OldList
#https://docs.microsoft.com/en-us/powershell/module/international/set-winuserlanguagelist?view=win10-ps 
```

• Use the desktop language bar when it's available:
```powershell
Set-WinLanguageBarOption -UseLegacyLanguageBar
#https://docs.microsoft.com/en-us/powershell/module/international/set-winlanguagebaroption?view=win10-ps 
```

• Change non-Unicode 
```powershell
#https://docs.microsoft.com/en-us/powershell/module/international/set-winsystemlocale?view=win10-ps
#https://blogs.technet.microsoft.com/benshy/2012/06/04/using-a-powershell-script-to-run-as-a-different-user-elevate-the-process/
Start-Process powershell -Verb RunAs -ArgumentList "Set-WinSystemLocale -SystemLocale zh-CN" 
shutdown -r -t 05
```

• Combine them together, then convert the code to EXE file in https://ps2exe.azurewebsites.net/
```powershell
$OldList = Get-WinUserLanguageList
$OldList.Add("zh-Hans-CN")
Set-WinUserLanguageList -LanguageList $OldList -Force -Confirm:$False
 
Set-WinLanguageBarOption -UseLegacyLanguageBar
 
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "LaunchTo" -Value 1
 
Start-Process powershell -Verb RunAs -ArgumentList "Set-WinSystemLocale -SystemLocale zh-CN"
 
shutdown -r -t 05 

```
