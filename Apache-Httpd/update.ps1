param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_AfterUpdate { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_GetLatest {
    $downloadPageUrl = 'http://www.apachehaus.com/cgi-bin/download.plx'
    $versionRegEx = 'httpd\-([0-9\.]+)\-x\d+\-(.*)\.zip'
    $url = 'https://www.apachehaus.com/downloads/httpd-$version-x64-$vcNumber.zip'

    $downloadPage = Invoke-WebRequest $downloadPageUrl -UseBasicParsing
    $matches = [regex]::match($downloadPage.Content, $versionRegEx)
    $version = [version]$matches.Groups[1].Value
    $vcNumber = $matches.Groups[2].Value

    $url = $ExecutionContext.InvokeCommand.ExpandString($url)

    if ($force) {
        $global:au_Version = $version
    }

    return @{ Url32 = $url; Version = $version }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')