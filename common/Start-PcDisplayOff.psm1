function Start-PcDisplayOff {
  <#
  .SYNOPSIS
    PCのディスプレイをオフにする

  .DESCRIPTION
    PCのディスプレイ表示のみをオフにする
    コマンド実行して2秒後に画面をオフにする
    スリープにはならず実行中のプロセスはそのまま実行される

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    なし

  .OUTPUTS
    なし

  .EXAMPLE
    PS> Start-PcDisplayOff
      PCのディスプレイをオフにする

  .EXAMPLE
    PS> Start-PcDisplayOff -Help
      ヘルプを表示する

  .LINK
    参考: Qiita記事「PowerShellメモ　シャットダウン、再起動、スリープ」
    https://qiita.com/Kosen-amai/items/4b773c077a588f2a2fb5
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Start-PcDisplayOff; return }

  #------------------------------
  # Main処理
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
  $form = New-Object System.Windows.Forms.Form
  $message = [System.Windows.Forms.Message]::Create($form.Handle, 274, 61808, 2)
  $nativeWindow = New-Object System.Windows.Forms.NativeWindow

  Start-Sleep -Seconds 2

  $nativeWindow.DefWndProc([ref]$message)
}
# コマンドレットをExport
Export-ModuleMember -Function Start-PcDisplayOff
