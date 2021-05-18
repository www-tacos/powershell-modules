function Show-Hello {
  <#
  .SYNOPSIS
    Helloと表示する

  .DESCRIPTION
    Helloを返し、コンソールでの実行であればHelloを表示する
    helloをエイリアスに設定する

  .PARAMETER Help|h
    ヘルプ表示のスイッチオン

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    なし

  .OUTPUTS
    文字列（Hello固定）

  .EXAMPLE
    PS> Show-Hello
      Helloを返す

  .EXAMPLE
    PS> Show-Hello -Help
      ヘルプを表示する

  .LINK
    参考: ヘルプの書き方
    http://www.vwnet.jp/Windows/PowerShell/SupportGetHelp.htm

    参考: モジュールの書き方
    https://docs.microsoft.com/ja-jp/powershell/scripting/developer/module/how-to-write-a-powershell-script-module
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Show-Hello; return }

  #------------------------------
  # Main処理
  #------------------------------
  Write-Output 'Hello'
}
# 関数をそのままExportする場合
# Export-ModuleMember -Function Show-Hello

# Aliasも設定してExportする場合
Set-Alias hello Show-Hello
Export-ModuleMember -Function Show-Hello -Alias hello
