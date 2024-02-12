function Start-PcSleep {
  <#
  .SYNOPSIS
    PCをスリープ状態にする

  .DESCRIPTION
    PCをスリープ状態にする

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    なし

  .OUTPUTS
    なし

  .EXAMPLE
    PS> Start-PcSleep
      PCをスリープさせる

  .EXAMPLE
    PS> Start-PcSleep -Help
      ヘルプを表示する

  .LINK
    参考: Qiita記事「PowerShellメモ　シャットダウン、再起動、スリープ」
    https://qiita.com/Kosen-amai/items/4b773c077a588f2a2fb5
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Start-PcSleep; return }

  #------------------------------
  # Main処理
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
  $state = [System.Windows.Forms.PowerState]::Suspend
  $force = $true
  $disableWakeEvent = $false
  [System.Windows.Forms.Application]::SetSuspendState($state, $force, $disableWakeEvent)
}
# コマンドレットをExport
Export-ModuleMember -Function Start-PcSleep
