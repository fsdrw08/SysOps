$psobject = Get-ChildItem

$header = ($psobject | ConvertTo-Csv -NoTypeInformation | Select-Object -First 1) -split ',' -replace '"',""

$psobject.($header[7])
