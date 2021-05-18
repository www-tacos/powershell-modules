function Get-ItemList {
  <#
  .SYNOPSIS
    指定パスのアイテムを表示する

  .DESCRIPTION
    Bashのlsコマンドのように指定パスのアイテム名のみを表示する
    デフォルトではコンソールへ表示する設定で、その場合は色付きで表示する
    リダイレクトモードにした場合は Get-ChildItem を指定パスに対して実行した結果を返す

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER Path
    アイテムリストを表示する対象のパス
    ディレクトリを指定した場合はディレクトリ内のアイテム名を対象とする
    ファイルを指定した場合はそのファイル名を対象とする

  .PARAMETER Redirect
    リダイレクトモードのスイッチ
    デフォルトはオフ
    オフの場合は Write-Host を用いてコンソールへ表示するためリダイレクトが不可能
    オンにした場合はオブジェクトを返すのでリダイレクト可能

    .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    パス文字列

  .OUTPUTS
    なし、もしくはオブジェクト配列

  .EXAMPLE
    PS> Get-ItemList
      カレントディレクトリの中身を表示する

  .EXAMPLE
    PS> Get-ItemList -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Get-ItemList ~/
      ホームディレクトリの中身の表示

  .EXAMPLE
    PS> Get-ItemList ~/Downloads/hoge.txt
      ファイル名の表示

  .EXAMPLE
    PS> Get-ItemList ~/ -Redirect
      ホームディレクトリの中身の配列の返却

  .LINK
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $Path = (Get-Location).Path,
    [switch] $Redirect = $false
  )
  if($Help){ Get-Help Get-ItemList; return }

  #------------------------------
  # Main処理
  #------------------------------
  # Redirect の場合は Get-ChildItem の結果をそのまま返す
  if($Redirect) {
    return Get-ChildItem $Path
  }

  # 色の設定
  $ColorFile = [System.ConsoleColor]::Green
  $ColorDirectory = [System.ConsoleColor]::Cyan

  # 表示上の区切り文字
  $SEPARATOR = " " * 6

  # TODO: コンソール幅を取得して途中改行を防ぐ場合は以下を使う
  # $maxWidth = $Host.UI.RawUI.WindowSize.Width

  Get-ChildItem $Path | ForEach-Object {
    if(Test-Path $_ -PathType Container) {
      # 対象アイテムが Directory の場合
      Write-Host -NoNewline $_.Name -Foreground $ColorDirectory
    } else {
      # 対象アイテムが File の場合
      Write-Host -NoNewline $_.Name -Foreground $ColorFile
    }
    # 区切り文字の表示
    Write-Host -NoNewline $SEPARATOR
  }
}
# 関数をそのままExportする場合
# Export-ModuleMember -Function Get-ItemList

# Aliasも設定してExportする場合
Set-Alias ls Get-ItemList
Export-ModuleMember -Function Get-ItemList -Alias ls
