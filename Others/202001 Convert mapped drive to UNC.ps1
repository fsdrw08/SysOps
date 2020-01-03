$mapping = Get-WmiObject -Class Win32_MappedLogicalDisk `
| Select-Object -property @{Name="key";Expression=Name},`
                        @{Name="value";Expression=ProviderName}

<# or
$mapping = @{
'D:' = '\\server1\tier1\tier2'
'E:' = '\\server2\tier1\tier2'
}
#>

$path = @()

#$folders = 
@"
D:\tier3\tier4
E:\tier3\tier4
"@ -split "`r`n" | ForEach-Object {
    $line = $_
    $mapping.GetEnumerator() | ForEach-Object {
        if ($line -match $_.key) {
            $line = $line -replace $_.key, $_.value
            $path += $line
        }
    }
}

$path
