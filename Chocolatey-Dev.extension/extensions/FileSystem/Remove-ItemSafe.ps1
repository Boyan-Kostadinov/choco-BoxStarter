function Remove-ItemSafe {
    [Alias("rms")]
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $path
    )

    Remove-Item -Recurse -Force -Path $path -ErrorAction SilentlyContinue
}