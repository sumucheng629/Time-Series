$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")
$rscript = "C:\Program Files\R\R-4.4.1\bin\Rscript.exe"
$rLibrary = "C:\Rlibs\4.4"
$rTemp = "C:\Rtmp"

if (-not (Test-Path -LiteralPath $rscript)) {
  throw "Rscript was not found at $rscript"
}

New-Item -ItemType Directory -Force -Path $rLibrary, $rTemp | Out-Null

$env:R_LIBS_USER = $rLibrary.Replace("\", "/")
$env:TEMP = $rTemp.Replace("\", "/")
$env:TMP = $rTemp.Replace("\", "/")

Push-Location -LiteralPath $repoRoot
try {
  & $rscript --vanilla -e ".libPaths('$($env:R_LIBS_USER)'); source('scripts/run_project.R')"
}
finally {
  Pop-Location
}
