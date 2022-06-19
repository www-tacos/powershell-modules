<#==================================================
モジュール読み込み用スクリプト for 6~
==================================================#>

# commonモジュールの変換（SJISからUTF8に変換して読み込む）
$DIR_SJIS = Join-Path $PSScriptRoot "common"
$DIR_UTF8 = Join-Path $PSScriptRoot "common_6"
if(Test-Path $DIR_SJIS -PathType Container) {
  New-Item $DIR_UTF8 -ItemType Directory -Force | Out-Null
  Get-ChildItem $DIR_SJIS | ForEach-Object {
    $FILE_SJIS = $_
    $FILE_UTF8 = Join-Path $DIR_UTF8 $FILE_SJIS.Name
    Get-Content $FILE_SJIS -Encoding 932 | Set-Content $FILE_UTF8 -Encoding utf8
  }
}

# 6用モジュールとcommonモジュールの読み込み
@("6", "common_6") | ForEach-Object {
  $ModuleDir = Join-Path $PSScriptRoot $_
  if(Test-Path $ModuleDir -PathType Container) {
    Write-Host "From: $(Split-Path $ModuleDir -Leaf)"
    Get-ChildItem $ModuleDir | ForEach-Object {
      try {
        Import-Module $_.FullName -Force
        Write-Host "Imported: $($_.BaseName)"
      } catch {
        Write-Host "Import Failed: $($_.BaseName)"
      }
    }
  }
}

