function Show-MsgBox {
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
    PS> Show-MsgBox
      <コマンドのみ実行時の処理内容>

  .EXAMPLE
    PS> Show-MsgBox -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Show-MsgBox <PARAM>
      <パラメータを指定したときの処理内容>

  .LINK
    参考: <参考サイト概要>
    <URL>
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if ($Help) { Get-Help Show-MsgBox; return }

  #------------------------------
  # Main処理
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
  # フォント
  $ValidFont = @(
    "Noto Sans Mono CJK JP Regular",
    "Noto Sans CJK JP Regular",
    "HackGenNerd",
    "Ricty Diminished",
    "源ノ角ゴシック Code JP N",
    "メイリオ",
    "ＭＳ ゴシック"
  ) | Where-Object {
    $_ -in [System.Drawing.FontFamily]::Families
  }
  $FONT = New-Object System.Drawing.Font($ValidFont[0], 12)

  $ok = New-Object System.Windows.Forms.Button -Property @{
    Text         = "OK"
    DialogResult = "OK"  # 列挙子名：None, OK, Cancel, Abort, Retry, Ignore, Yes, No
    Size         = New-Object System.Drawing.Size(10, 10)
    Location     = New-Object System.Drawing.Point(-20, -20)
  }

  $content = ((Get-Content "${PSScriptRoot}/Restart-IME.psm1") -join "`r`n")
  # Formの作成
  $form = New-Object System.Windows.Forms.Form -Property @{
    Text            = "Message"
    Topmost         = $true
    StartPosition   = "CenterScreen"
    SizeGripStyle   = "Hide"
    FormBorderStyle = "FixedSingle"
    MinimizeBox     = $false
    MaximizeBox     = $false
    AutoSize        = $true
    AutoSizeMode    = "GrowAndShrink"
    CancelButton    = $ok
  }

  # ラベルの設定
  $txt = New-Object System.Windows.Forms.Label -Property @{
    Text     = "${content}"
    Font     = $FONT
    AutoSize = $true
    Location = New-Object System.Drawing.Point(0, 0)
  }
  # ボタン等をフォームに追加
  $form.Controls.Add($txt)
  $form.Controls.Add($ok)
  # フォームを表示させる
  $form.ShowDialog() > $null
}
# コマンドレットをExport
Export-ModuleMember -Function Show-MsgBox
