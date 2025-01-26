Write-Host "Import custom modules."
foreach ($Edition in @("common", "Desktop", "Core")) {
  if ($Edition -ceq "common" -or $Edition -eq $PSEdition) {
    $ModuleDir = "${PSScriptRoot}\${Edition}"
    $ModuleList = Get-ChildItem $ModuleDir -Filter "*.psm1"
    foreach ($Module in $ModuleList) {
      try {
        Import-Module $Module.FullName -Force
        Write-Host "Success: ${Edition} > $($Module.BaseName)" -ForegroundColor Green
      }
      catch {
        Write-Host "Failure: ${Edition} > $($Module.BaseName)" -ForegroundColor Red
      }
    }
  }
}
