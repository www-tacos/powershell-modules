# desktopモジュールの読み込み
$ModuleDir = Join-Path $PSScriptRoot "desktop"
if (Test-Path $ModuleDir -PathType Container) {
  Get-ChildItem $ModuleDir | ForEach-Object {
    try {
      Import-Module $_.FullName -Force
      Write-Host "Imported: $($_.BaseName)"
    }
    catch {
      Write-Host "Import Failed: $($_.BaseName)" -ForegroundColor Red
    }
  }
}
