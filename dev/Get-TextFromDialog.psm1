function Get-TextFromDialog {
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
    PS> Get-TextFromDialog
      <コマンドのみ実行時の処理内容>
  
  .EXAMPLE
    PS> Get-TextFromDialog -Help
      ヘルプを表示する
  
  .EXAMPLE
    PS> Get-TextFromDialog <PARAM>
      <パラメータを指定したときの処理内容>
  
  .LINK
    参考: TextBox クラス
    https://docs.microsoft.com/ja-jp/dotnet/api/system.windows.forms.textbox?view=net-5.0

    参考: フォームサイズ固定
    https://stackoverflow.com/questions/7970262/disable-resizing-of-a-windows-forms-form
    #>
  Param(
    [Alias('h')][switch] $Help,
    [int] $TextAriaSize = 60,
    [string]$Description = "テキストを入力してください"
  )
  if($Help){ Get-Help Get-TextFromDialog; return }

  #------------------------------
  # Main処理
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms

  # サイズ値の計算
  $MARGIN = 20
  $BTN_WIDTH = 80
  $BTN_HEIGHT = 30
  $TBX_WIDTH = ($BTN_WIDTH + $MARGIN) * 2
  $TBX_HEIGHT = $BTN_HEIGHT
  $FRM_WIDTH = ($BTN_WIDTH + $MARGIN * 2) * 2
  $FRM_HEIGHT = ($BTN_HEIGHT + $MARGIN * 2) + ($TBX_HEIGHT + $MARGIN * 2)

  # フォントの設定
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

  # フォームの設定
  $form = New-Object System.Windows.Forms.Form -Property @{
    Text = "Input Box"
    Size = New-Object System.Drawing.Size(300,180)
    Topmost = $true
    StartPosition = "CenterScreen"
    SizeGripStyle = "Hide"
    FormBorderStyle = "FixedSingle"
  }

  # OKボタンの設定
  $OKButton = New-Object System.Windows.Forms.Button -Property @{
    Text = "OK"
    DialogResult = "OK"  # 列挙子名：None, OK, Cancel, Abort, Retry, Ignore, Yes, No
    Size = New-Object System.Drawing.Size(75,30)
    Location = New-Object System.Drawing.Point(60,100)
  }

  # キャンセルボタンの設定
  $CancelButton = New-Object System.Windows.Forms.Button -Property @{
    Text = "Cancel"
    DialogResult = "Cancel"  # 列挙子名：None, OK, Cancel, Abort, Retry, Ignore, Yes, No
    Size = New-Object System.Drawing.Size(75,30)
    Location = New-Object System.Drawing.Point(150,100)
  }

  # ラベルの設定
  $label = New-Object System.Windows.Forms.Label -Property @{
    Text = 'テキストを入力してください'
    Size = New-Object System.Drawing.Size(250,20)
    Location = New-Object System.Drawing.Point(10,30)
  }

  # 入力ボックスの設定
  $textBox = New-Object System.Windows.Forms.TextBox -Property @{
    Font = $FONT
    Size = New-Object System.Drawing.Size(250,50)
    Location = New-Object System.Drawing.Point(10,60)
    Multiline = $true
    ScrollBars = "Vertical"
    AcceptsReturn = $true
    WordWrap = $true
  }

  # キーとボタンの関係
  $form.AcceptButton = $OKButton
  $form.CancelButton = $CancelButton

  # ボタン等をフォームに追加
  $form.Controls.Add($OKButton)
  $form.Controls.Add($CancelButton)
  $form.Controls.Add($label)
  $form.Controls.Add($textBox)

  # フォームを表示させ、その結果を受け取る
  $result = $form.ShowDialog()

  # 結果による処理分岐
  if ($result -eq "OK") {
    return $textBox.Text
  } else {
    return ""
  }
}
# 関数をそのままExportする場合
Export-ModuleMember -Function Get-TextFromDialog

# Aliasも設定してExportする場合
# Set-Alias <alias> Get-TextFromDialog
# Export-ModuleMember -Function Get-TextFromDialog -Alias <alias>
