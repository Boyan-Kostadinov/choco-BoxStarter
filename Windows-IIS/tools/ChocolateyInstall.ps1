﻿$updatedOn = '2017.06.08 09:16:44'
$defaultConfigFile = Join-Path $env:ChocolateyPackageFolder 'IIS.config'
$parameters = Get-Parameters $env:packageParameters
$configurationFile = Get-ConfigurationFile $parameters['file'] $defaultConfigFile

if ([System.Environment]::OSVersion.Version.Major -ge 6 -and [System.Environment]::OSVersion.Version.Minor -gt 0) {
    # .NET and extensibility
    Enable-WindowsFeature NetFx3
    Enable-WindowsFeature NetFx4Extended-ASPNET45

    # Web server
    Enable-WindowsFeature IIS-WebServer
    Enable-WindowsFeature IIS-ManagementConsole

    # ASP.NET
    Enable-WindowsFeature IIS-ASPNET
    Enable-WindowsFeature IIS-ASPNET45
}
else {
    Enable-WindowsFeatures $configurationFile
}
