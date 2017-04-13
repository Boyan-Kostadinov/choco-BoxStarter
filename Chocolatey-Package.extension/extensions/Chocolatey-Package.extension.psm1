# Export functions that start with capital letter, others are private
# Include file names that start with capital letters, ignore others
$scriptRoot = Split-Path $MyInvocation.MyCommand.Definition

$global:mustDismountIso = $false
$global:pinTool = (Join-Path $PSScriptRoot 'Tools\syspin.exe')

$pre = Get-ChildItem Function:\*

Get-ChildItem -Recurse "$scriptRoot\*.ps1" | Where-Object { $_.Name -cmatch '^[A-Z]+' } | ForEach-Object { . $_  }

$post = Get-ChildItem Function:\*

$funcs = Compare-Object $pre $post | Select-Object -Expand InputObject | Select-Object -Expand Name
$funcs | Where-Object { $_ -cmatch '^[A-Z]+'} | ForEach-Object { Export-ModuleMember -Function $_ }