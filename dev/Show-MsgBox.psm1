function Show-MsgBox {
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
    PS> Show-MsgBox
      <�R�}���h�̂ݎ��s���̏������e>

  .EXAMPLE
    PS> Show-MsgBox -Help
      �w���v��\������

  .EXAMPLE
    PS> Show-MsgBox <PARAM>
      <�p�����[�^���w�肵���Ƃ��̏������e>

  .LINK
    �Q�l: <�Q�l�T�C�g�T�v>
    <URL>
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Show-MsgBox; return }

  #------------------------------
  # Main����
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
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

  $ok = New-Object System.Windows.Forms.Button -Property @{
    Text = "OK"
    DialogResult = "OK"  # �񋓎q���FNone, OK, Cancel, Abort, Retry, Ignore, Yes, No
    Size = New-Object System.Drawing.Size(10,10)
    Location = New-Object System.Drawing.Point(-20,-20)
  }

  $content = ((Get-Content "${PSScriptRoot}/Restart-IME.psm1") -join "`r`n")
  # Form�̍쐬
  $form = New-Object System.Windows.Forms.Form -Property @{
    Text = "Message"
    Topmost = $true
    StartPosition = "CenterScreen"
    SizeGripStyle = "Hide"
    FormBorderStyle = "FixedSingle"
    MinimizeBox = $false
    MaximizeBox = $false
    AutoSize = $true
    AutoSizeMode = "GrowAndShrink"
    CancelButton = $ok
  }

  # ���x���̐ݒ�
  $txt = New-Object System.Windows.Forms.Label -Property @{
    Text = "${content}"
    Font = $FONT
    AutoSize = $true
    Location = New-Object System.Drawing.Point(0, 0)
  }
  # �{�^�������t�H�[���ɒǉ�
  $form.Controls.Add($txt)
  $form.Controls.Add($ok)
  # �t�H�[����\��������
  $form.ShowDialog() > $null
}
# �R�}���h���b�g��Export
Export-ModuleMember -Function Show-MsgBox
