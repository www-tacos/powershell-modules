function Import-VBA {
  <#
  .SYNOPSIS
    <コマンドの概要>

  .DESCRIPTION
    <コマンドの説明>

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
    PS> Import-VBA
      <コマンドのみ実行時の処理内容>

  .EXAMPLE
    PS> Import-VBA -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Import-VBA <PARAM>
      <パラメータを指定したときの処理内容>

  .LINK
    参考: <参考サイト概要>
    <URL>
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if ($Help) { Get-Help Import-VBA; return }

  #------------------------------
  # Main処理
  #------------------------------
  # Open(fullname)
  # book.VBProject.VBComponents.Import(fullname)
  # book.save()
}
# コマンドレットをExport
Export-ModuleMember -Function Import-VBA
