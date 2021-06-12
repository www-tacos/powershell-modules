function Get-TextFromDialog {
  <#
  .SYNOPSIS
    <�R�}���h�̊T�v>
  
  .DESCRIPTION
    <�R�}���h�̐���>
  
  .PARAMETER Help|h
    �w���v��\������
  
  .PARAMETER <PARAM>
    <�p�����[�^�̐���>
  
  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���
  
  .INPUTS
    <���͂̊T�v>
  
  .OUTPUTS
    <�o�͂̊T�v>
  
  .EXAMPLE
    PS> Get-TextFromDialog
      <�R�}���h�̂ݎ��s���̏������e>
  
  .EXAMPLE
    PS> Get-TextFromDialog -Help
      �w���v��\������
  
  .EXAMPLE
    PS> Get-TextFromDialog <PARAM>
      <�p�����[�^���w�肵���Ƃ��̏������e>
  
  .LINK
    �Q�l: TextBox �N���X
    https://docs.microsoft.com/ja-jp/dotnet/api/system.windows.forms.textbox?view=net-5.0

    �Q�l: �t�H�[���T�C�Y�Œ�
    https://stackoverflow.com/questions/7970262/disable-resizing-of-a-windows-forms-form
    #>
  Param(
    [Alias('h')][switch] $Help,
    [int] $TextAriaSize = 60,
    [string]$Description = "�e�L�X�g����͂��Ă�������"
  )
  if($Help){ Get-Help Get-TextFromDialog; return }

  #------------------------------
  # Main����
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms

  # �T�C�Y�l�̌v�Z
  $MARGIN = 20
  $BTN_WIDTH = 80
  $BTN_HEIGHT = 30
  $TBX_WIDTH = ($BTN_WIDTH + $MARGIN) * 2
  $TBX_HEIGHT = $BTN_HEIGHT
  $FRM_WIDTH = ($BTN_WIDTH + $MARGIN * 2) * 2
  $FRM_HEIGHT = ($BTN_HEIGHT + $MARGIN * 2) + ($TBX_HEIGHT + $MARGIN * 2)

  # �t�H���g�̐ݒ�
  # �t�H���g
  $ValidFont = @(
    "Noto Sans Mono CJK JP Regular",
    "Noto Sans CJK JP Regular",
    "HackGenNerd",
    "Ricty Diminished",
    "���m�p�S�V�b�N Code JP N",
    "���C���I",
    "�l�r �S�V�b�N"
   ) | Where-Object {
    $_ -in [System.Drawing.FontFamily]::Families
  }
  $FONT = New-Object System.Drawing.Font($ValidFont[0], 12)

  # �t�H�[���̐ݒ�
  $form = New-Object System.Windows.Forms.Form -Property @{
    Text = "Input Box"
    Size = New-Object System.Drawing.Size(300,180)
    Topmost = $true
    StartPosition = "CenterScreen"
    SizeGripStyle = "Hide"
    FormBorderStyle = "FixedSingle"
  }

  # OK�{�^���̐ݒ�
  $OKButton = New-Object System.Windows.Forms.Button -Property @{
    Text = "OK"
    DialogResult = "OK"  # �񋓎q���FNone, OK, Cancel, Abort, Retry, Ignore, Yes, No
    Size = New-Object System.Drawing.Size(75,30)
    Location = New-Object System.Drawing.Point(60,100)
  }

  # �L�����Z���{�^���̐ݒ�
  $CancelButton = New-Object System.Windows.Forms.Button -Property @{
    Text = "Cancel"
    DialogResult = "Cancel"  # �񋓎q���FNone, OK, Cancel, Abort, Retry, Ignore, Yes, No
    Size = New-Object System.Drawing.Size(75,30)
    Location = New-Object System.Drawing.Point(150,100)
  }

  # ���x���̐ݒ�
  $label = New-Object System.Windows.Forms.Label -Property @{
    Text = '�e�L�X�g����͂��Ă�������'
    Size = New-Object System.Drawing.Size(250,20)
    Location = New-Object System.Drawing.Point(10,30)
  }

  # ���̓{�b�N�X�̐ݒ�
  $textBox = New-Object System.Windows.Forms.TextBox -Property @{
    Font = $FONT
    Size = New-Object System.Drawing.Size(250,50)
    Location = New-Object System.Drawing.Point(10,60)
    Multiline = $true
    ScrollBars = "Vertical"
    AcceptsReturn = $true
    WordWrap = $true
  }

  # �L�[�ƃ{�^���̊֌W
  $form.AcceptButton = $OKButton
  $form.CancelButton = $CancelButton

  # �{�^�������t�H�[���ɒǉ�
  $form.Controls.Add($OKButton)
  $form.Controls.Add($CancelButton)
  $form.Controls.Add($label)
  $form.Controls.Add($textBox)

  # �t�H�[����\�������A���̌��ʂ��󂯎��
  $result = $form.ShowDialog()

  # ���ʂɂ�鏈������
  if ($result -eq "OK") {
    return $textBox.Text
  } else {
    return ""
  }
}
# �֐������̂܂�Export����ꍇ
Export-ModuleMember -Function Get-TextFromDialog

# Alias���ݒ肵��Export����ꍇ
# Set-Alias <alias> Get-TextFromDialog
# Export-ModuleMember -Function Get-TextFromDialog -Alias <alias>
