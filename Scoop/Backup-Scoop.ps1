"check scoop cache"
scoop cache

if ((Read-Host "Are you sure remove scoop cache? y/N") -eq "y") {
"remove scoop cache"
scoop cache rm *
}

"check apps install by scoop"
scoop list

"before backup, close all apps install by scoop"

if ((Read-Host "Are you sure all scoop apps had closed? y/N") -eq "y") {
  #for run separately
  $Destination = ""
  
  
  #for run as a script file
  $Destination = $PSScriptRoot
  
  if (Test-Path $env:USERPROFILE\scoop\apps\7zip\current\) {
  
    "Copy scoop's 7z.exe & 7z.dll to current path"
    Copy-Item -Path "$env:USERPROFILE\scoop\apps\7zip\current\7z.dll" -Destination $Destination -Force
    Copy-Item -Path "$env:USERPROFILE\scoop\apps\7zip\current\7z.exe" -Destination $Destination -Force
    
    
    #Show-Tree -Path $env:USERPROFILE\scoop\apps\ -Depth 2 -ShowProperty mode
    
    "Remove the `"current`" folder in scoop apps"
    Get-Item $env:USERPROFILE\scoop\apps\*\current | ForEach-Object {
      if ($_.mode -eq "d-r--l") {
      Remove-Item $_.FullName -Recurse -Force -Confirm:$false
      }
    }
    
    "backup scoop - add scoop folder to archive"
    . (Join-Path $Destination "7z.exe") a $Destination\Scoop.7z $env:USERPROFILE\scoop\
    
    "add the current folder back"
    Get-ChildItem "$env:USERPROFILE\scoop\apps\" | Select-Object -ExpandProperty fullname | ForEach-Object {
        if ((Get-ChildItem $_ | Select-Object -ExpandProperty name) -notcontains "current") {
            $Target = Get-ChildItem $_ | Select-Object -First 1 | Select-Object -ExpandProperty fullname
            New-Item -ItemType Junction -Path "$_\current" -Target $Target
        }
    }
    scoop reset *

    "Backup done, please enter to close the window"
    Pause
  } else {
  "You should run `"scoop install 7z`" first"
  }

} else {
  "close the running scoop apps first"
}
