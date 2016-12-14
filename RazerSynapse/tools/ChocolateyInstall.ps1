$script           = $MyInvocation.MyCommand.Definition
$packageArgs      = @{
  packageName     = 'RazerSynapse'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'exe'
  file            = Join-Path (Get-ParentDirectory $script) 'Razer_Synapse_Framework_V2.20.15.1104.exe'
  url             = 'https://www.razerzone.com/synapse/downloadpc'
  softwareName    = 'RazerSynapse*'
  checksum        = 'A568786FEE965F8AC2B8F9942521E1D2B08EFFC566D8471917C2233FEA49700F'
  checksumType    = 'sha256'
  silentArgs      = '/s'
  validExitCodes  = @(0, 3010, 1641)
}

Start-Process (Join-Path (Get-ParentDirectory $script) 'Install.exe')

Start-Sleep 10

Install-LocalOrRemote $packageArgs