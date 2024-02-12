function Show-Toast {
  <#
  .SYNOPSIS
    �g�[�X�g�ʒm��\������

  .DESCRIPTION
    ���̓e�L�X�g���g�[�X�g�`���̒ʒm�Ƃ��ĕ\������
    �g�[�X�g�ʒm��5�b���炢�Ŏ����I�ɉB���
    �����̃g�[�X�g���쐬�����ꍇ�A�\�����̃g�[�X�g���B��Ă��玟�̃g�[�X�g���\�������
    �B�ꂽ�ʒm��Windows�̒ʒm�o�[����m�F�Ə������ł���

  .PARAMETER Help|h
    �w���v��\������

  .PARAMETER Message
    �g�[�X�g�ʒm�ɕ\������e�L�X�g
    ���s���� ('`n') �ŉ��s���܂߂邱�Ƃ��\�i�������\���ł���̂�6�s�܂Łj
    �p�C�v���C���Ŏ󂯎�邱�Ƃ��\

  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���

  .INPUTS
    ������

  .OUTPUTS
    �g�[�X�g�ʒm

  .EXAMPLE
    PS> Show-Toast
      �u�V�����ʒm�v�Ƃ�����̒ʒm���\�������

  .EXAMPLE
    PS> Show-Toast -Help
      �w���v��\������

  .EXAMPLE
    PS> Show-Toast "Hello`nToast"
      �g�[�X�g�ʒm�ŁuHello<���s>Toast�v��\������

  .LINK
    �Q�l: Qiita�L��
    https://qiita.com/magiclib/items/12e2a9e1e1e823a7fa5c

    �Q�l: �����h�L�������g
    https://docs.microsoft.com/en-us/windows/uwp/design/shell/tiles-and-notifications/toast-schema
  #>
  Param(
    [Alias('h')][switch] $Help,
    [Parameter(ValueFromPipeline = $true)] [String] $Message
  )
  if($Help){ Get-Help Show-Toast; return }

  #------------------------------
  # Main����
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
# �R�}���h���b�g��Export
Export-ModuleMember -Function Show-Toast
