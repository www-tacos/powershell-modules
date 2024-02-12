function Show-Toast {
  <#
  .SYNOPSIS
    トースト通知を表示する

  .DESCRIPTION
    入力テキストをトースト形式の通知として表示する
    トースト通知は5秒くらいで自動的に隠れる
    複数のトーストを作成した場合、表示中のトーストが隠れてから次のトーストが表示される
    隠れた通知はWindowsの通知バーから確認と消去ができる

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER Message
    トースト通知に表示するテキスト
    改行文字 ('`n') で改行を含めることも可能（ただし表示できるのは6行まで）
    パイプラインで受け取ることも可能

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    文字列

  .OUTPUTS
    トースト通知

  .EXAMPLE
    PS> Show-Toast
      「新しい通知」という空の通知が表示される

  .EXAMPLE
    PS> Show-Toast -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Show-Toast "Hello`nToast"
      トースト通知で「Hello<改行>Toast」を表示する

  .LINK
    参考: Qiita記事
    https://qiita.com/magiclib/items/12e2a9e1e1e823a7fa5c

    参考: 公式ドキュメント
    https://docs.microsoft.com/en-us/windows/uwp/design/shell/tiles-and-notifications/toast-schema
  #>
  Param(
    [Alias('h')][switch] $Help,
    [Parameter(ValueFromPipeline = $true)] [String] $Message
  )
  if($Help){ Get-Help Show-Toast; return }

  #------------------------------
  # Main処理
  #------------------------------
  [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
  [Windows.UI.Notifications.ToastNotification, Windows.UI.Notifications, ContentType = WindowsRuntime] > $null
  [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] > $null

  $APP_ID = '{1AC14E77-02E7-4E5D-B744-2EB1AE5198B7}\WindowsPowerShell\v1.0\powershell.exe'
  $CONTENT = @"
<?xml version="1.0" encoding="utf-8"?>
<toast duration="short">
  <visual>
    <binding template="ToastGeneric">
      <text>${Message}</text>
  </binding>
</visual>
</toast>
"@
  $XML = New-Object Windows.Data.Xml.Dom.XmlDocument
  $XML.LoadXml($CONTENT)
  $TOAST = New-Object Windows.UI.Notifications.ToastNotification $XML
  [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier($APP_ID).Show($TOAST)
}
# コマンドレットをExport
Export-ModuleMember -Function Show-Toast
