function Install-WithScheduledTask() {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][Hashtable] $arguments
    )

    $packageArgs = Get-Arguments $arguments

    if (!(Test-FileExists $packageArgs.file)) {
        Write-Message "Install-WithScheduledTask: Downloading from '$($packageArgs.url)'"
        $packageArgs.file = Get-ChocolateyWebFile @packageArgs
    }

    Write-Message "Install-WithScheduledTask: Installing '$($packageArgs.file)'"
    Invoke-ScheduledTask $packageArgs.packageName $packageArgs.file $packageArgs.silentArgs
}