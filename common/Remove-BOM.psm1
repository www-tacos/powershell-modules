function Remove-BOM {
  <#
  .SYNOPSIS
    BOM付きUTF-8のファイルをUTF-8に変換する

  .DESCRIPTION
    BOM付きUTF-8のファイルからBOMを削除しUTF-8ファイルに変換する

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER FilePath
    BOM付きUTF-8のファイル

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    ファイルパス

  .OUTPUTS
    変換ファイル

  .EXAMPLE
    PS> Remove-BOM -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Remove-BOM -Path ~/Downloads/sample_utf8bom.txt
      BOMなしのUTF-8形式で ~/Downloads/sample_utf8bom.txt を上書きする

  .EXAMPLE
    PS> Remove-BOM -Path ~/Downloads/sample_utf8bom.txt -BackUp
      BOMなしのUTF-8形式で ~/Downloads/sample_utf8bom.txt を上書きする
      元のファイルは ~/Downloads/sample_utf8bomk.yyyymmdd_hhmmss.txt でバックアップする

  .LINK
    参考: <参考サイト概要>
    <URL>
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $FilePath,
    [switch] $BackUp
  )
  if($Help){ Get-Help Remove-BOM; return }

  #------------------------------
  # Main処理
  #------------------------------
  if(-not (Test-Path $FilePath -PathType Leaf)) {
    throw "Error: ファイルを指定してください。（${FilePath}）"
  }
  if($BackUp) {
    $_f = Get-Item $FilePath
    $_ts = (Get-Date).ToString("yyyyMMdd_HHmmss")
    $_bkup = "$($_f.DirectoryName)/$($_f.BaseName)_${_ts}$($_f.Extension)"
    Copy-Item $_f $_bkup
  }
  $text = Get-Content $FilePath
  $UTF8_NO_BOM_ENCODING = New-Object System.Text.UTF8Encoding($False)
  [System.IO.File]::WriteAllLines($FilePath, $text, $UTF8_NO_BOM_ENCODING)
}
# コマンドレットをExport
Export-ModuleMember -Function Remove-BOM
