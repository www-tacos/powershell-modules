function Show-MessageDialog {
  <#
  .SYNOPSIS
  ここに概要を書きます
  
  .DESCRIPTION
  ここに説明を書きます
  
  .EXAMPLE
  ここに具体的な引数の例と解説を書きます(複数記述可)
  
  .EXAMPLE
  ここに具体的な引数の例と解説を書きます(複数記述可)
  
  .PARAMETER 引数名
  ここら引数の説明を書きます(複数記述可)
  
  .PARAMETER 引数名
  ここら引数の説明を書きます(複数記述可)
  
  PARAMETER には CommonParameters について説明が勝手に追加されるので
  「<CommonParameters> はサポートしていません」と書いておくと良いかもしれません。
  
  .LINK
  関連するリンクの URL を書きます
  http://www.vwnet.jp/Windows/PowerShell/SupportGetHelp.htm
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Show-MessageDialog; return }

  ##### WRITE CODE HERE #####
}
Export-ModuleMember -Function Show-MessageDialog

<#
@fn
JavaScriptの alert のようにダイアログを表示する
@param title アラートダイアログのタイトルバーの文字
@param desc アラートダイアログで表示する文字列

function alert {
  Param(
      [string]$title = "アラート",
      [string]$desc = "OKを押してください"
  )
  [void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
  # フォームの設定
  $form = New-Object System.Windows.Forms.Form
  @{
      "Text" = "$title"
      "Size" = New-Object System.Drawing.Size(300,180)
      "Topmost" = $true
      "StartPosition" = "CenterScreen"
  }.GetEnumerator() | ForEach-Object {
      $form.($_.Key) = $_.Value
  }

  # OKボタンの設定
  $OKButton = New-Object System.Windows.Forms.Button
  @{
      "Text" = "OK"
      "DialogResult" = "OK"  # 列挙子名：None, OK, Cancel, Abort, Retry, Ignore, Yes, No
      "Size" = New-Object System.Drawing.Size(100,30)
      "Location" = New-Object System.Drawing.Point(100,100)
  }.GetEnumerator() | ForEach-Object {
      $OKButton.($_.Key) = $_.Value
  }

  # ラベルの設定
  $label = New-Object System.Windows.Forms.Label
  @{
      "Text" = $title
      "Size" = New-Object System.Drawing.Size(260,20)
      "Location" = New-Object System.Drawing.Point(20,30)
  }.GetEnumerator() | ForEach-Object {
      $label.($_.Key) = $_.Value
  }

  # キーとボタンの関係
  $form.AcceptButton = $OKButton

  # ボタン等をフォームに追加
  $form.Controls.Add($OKButton)
  $form.Controls.Add($label) 

  # フォームを表示させ、その結果を受け取る
  $form.ShowDialog() > $null
}


#>