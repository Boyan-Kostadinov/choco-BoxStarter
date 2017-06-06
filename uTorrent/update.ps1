param([switch] $force, [switch] $push)

$packageDir = $PSScriptRoot

. (Join-Path $PSScriptRoot '..\Scripts\update.begin.ps1')

function global:au_GetLatest {
    $downloadPageUrl = 'http://www.utorrent.com/downloads/win'
    $versionRegEx = 'Stable\(([0-9\.]+) build (\d+)\)'
    $url = 'http://download.ap.bittorrent.com/track/stable/endpoint/utorrent/os/windows'
    $fileName32 = 'uTorrent.exe'

    $downloadPage = Invoke-WebRequest $downloadPageUrl -UseBasicParsing
    $matches = [regex]::match($downloadPage.Content, $versionRegEx)
    $version = [version]"$($matches.Groups[1].Value).$($matches.Groups[2].Value)"

    return @{ Url32 = $url; Version = $version; FileName32 = $fileName32; FileType = 'exe' }
}

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(file\s*=\s*)('.*')"     = "`$1'$($Latest.FileName32)'"
            "(?i)(url\s*=\s*)('.*')"      = "`$1'$($Latest.Url32)'"
            "(?i)(checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
    }
}

. (Join-Path $PSScriptRoot '..\Scripts\update.end.ps1')