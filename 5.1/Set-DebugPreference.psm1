function Set-DebugPreference {
  <#
  .SYNOPSIS
  デバッグモードの設定
  
  .DESCRIPTION
  デバッグモードを設定する
  デフォルトでは SilentlyContinue に設定されている
  タブ補完でデバッグモードを設定可能
  
  .EXAMPLE
  PS> Set-DebugPreference -Mode Continue
  デバッグモードを Continue に設定する
  
  .EXAMPLE
  PS> Set-DebugPreference
  デバッグモードをデフォルトに戻す
  
  PARAMETER には CommonParameters について説明が勝手に追加されるので
  「<CommonParameters> はサポートしていません」と書いておくと良いかもしれません。
  
  .LINK
  関連するリンクの URL を書きます
  https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/About/about_Preference_Variables?view=powershell-7.1#debugpreference
  #>
  Param(
    [Alias('h')][switch] $Help,
    [ValidateSet(
      "SilentlyContinue",  # 何もなし
      "Continue",  # Write-Debugを表示して処理を進める
      "Inquire",  # Write-Debugを表示して処理を進めるか聞く
      "Stop"  # Write-Debugを表示して処理を止める
    )][string] $Mode = "SilentlyContinue"
  )
  if($Help){ Get-Help Set-DebugPreference; return }

  $Global:DebugPreference = $Mode
}
Export-ModuleMember -Function Set-DebugPreference
