function Get-CurrentDirectory([string] $path) {
    if ([System.IO.File]::Exists($path)) {
        return $(Split-Path -Parent $path)
    }

    return $path
}