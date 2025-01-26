function Export-VBA {
  <#
  .SYNOPSIS
    エクセルマクロファイルからVBAを抽出する

  .DESCRIPTION
    xlsmファイルのVBAを抽出する

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER <PARAM>
    <パラメータの説明>

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    <入力の概要>

  .OUTPUTS
    <出力の概要>

  .EXAMPLE
    PS> Export-VBA
      <コマンドのみ実行時の処理内容>

  .EXAMPLE
    PS> Export-VBA -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Export-VBA <PARAM>
      <パラメータを指定したときの処理内容>

  .LINK
    参考: <参考サイト概要>
    <URL>
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $Path
  )
  if ($Help) { Get-Help Export-VBA; return }

  #------------------------------
  # Main処理
  #------------------------------
  if (! (Test-Path $Path -PathType Leaf)) {
    throw "file not found"
  }
  else {
    $f = Get-Item -LiteralPath "$Path"
  }
  $EXCEL = New-Object -ComObject Excel.Application
  try {
    $EXCEL.Workbooks.Open($f.FullName) | % {
      $_.VBProject.VBComponents | % {
        $exportFileName = Join-Path $f.DirectoryName ($_.Name + ".vba")
        $_.Export($exportFileName)
      }
    }
  }
  catch {
    Write-Error $PSItem.Exception
  }
  finally {
    $EXCEL.Quit()
    $EXCEL = $null
    [System.GC]::Collect()
  }
}
# コマンドレットをExport
Export-ModuleMember -Function Export-VBA
