$ErrorActionPreference = 'Stop'
$owner = 'amoedo7'
$repo = 'StoreAMO'
$api = "https://api.github.com/repos/$owner/$repo/releases/latest"
$web = "https://github.com/$owner/StoreAMO-Web"

try {
    $release = Invoke-RestMethod -Uri $api -Headers @{ 'User-Agent' = 'StoreAMO-Install/1' }
} catch {
    Write-Host 'StoreAMO: todavía no existe una Release oficial estable.'
    Write-Host "StoreAMO Web: $web"
    Start-Process $web
    return
}

$asset = $release.assets | Where-Object {
    $_.name -match '^StoreAMO-.*\.(msix|msi|exe|zip)$'
} | Select-Object -First 1

if (-not $asset) {
    Write-Host 'StoreAMO: todavía no hay cliente nativo oficial para Windows.'
    Write-Host "Abriendo StoreAMO Web: $web"
    Start-Process $web
    return
}

$url = [string]$asset.browser_download_url
$prefix = "https://github.com/$owner/$repo/releases/download/"
if (-not $url.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
    throw 'Origen de descarga inesperado.'
}

$dir = Join-Path $env:USERPROFILE 'Downloads\StoreAMO'
New-Item -ItemType Directory -Force -Path $dir | Out-Null
$out = Join-Path $dir $asset.name
Write-Host "Descargando $($asset.name)…"
Invoke-WebRequest -Uri $url -OutFile $out -Headers @{ 'User-Agent' = 'StoreAMO-Install/1' }
Write-Host "Descargado: $out"
Start-Process $out
