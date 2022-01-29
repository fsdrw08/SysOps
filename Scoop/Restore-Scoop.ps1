#for run separately
$Destination = ""
    
#for run as a script file
$Destination = $PSScriptRoot
 
#set variable for the process
$ScoopBackup = Join-Path $Destination "scoop.7z"
$7zexe = Join-Path $Destination "7z.exe"

$condition = (test-path $ScoopBackup) `
              -and (test-path $7zexe)

if ($condition) {
  "Extract Scoop to $env:USERPROFILE"
  . $7zexe x $ScoopBackup -o"$env:USERPROFILE\"

  "Add scoop shims path to user environment variable"
  $path = [Environment]::GetEnvironmentVariable('path','user')
  if (!($path -split ";" | Select-String shim)) {
    $newpath = $path + ";" + "$env:USERPROFILE\scoop\shims;"
    [Environment]::SetEnvironmentVariable('path',$newpath,'user')
  }
  
  "reset scoop"
  Get-ChildItem "$env:USERPROFILE\scoop\apps\" | Select-Object -ExpandProperty fullname | ForEach-Object {
        if ((Get-ChildItem $_ | Select-Object -ExpandProperty name) -notcontains "current") {
            $Target = Get-ChildItem $_ | Select-Object -First 1 | Select-Object -ExpandProperty fullname
            New-Item -ItemType Junction -Path "$_\current" -Target $Target
        }
  }
  . $env:USERPROFILE\scoop\shims\scoop reset *

  "modify powershell execution policy"
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
} else {
  "Check your backup file and 7z.exe"
}
