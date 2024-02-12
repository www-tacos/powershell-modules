function Start-PcDisplayOff {
  <#
  .SYNOPSIS
    PC�̃f�B�X�v���C���I�t�ɂ���

  .DESCRIPTION
    PC�̃f�B�X�v���C�\���݂̂��I�t�ɂ���
    �R�}���h���s����2�b��ɉ�ʂ��I�t�ɂ���
    �X���[�v�ɂ͂Ȃ炸���s���̃v���Z�X�͂��̂܂܎��s�����

  .PARAMETER Help|h
    �w���v��\������

  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���

  .INPUTS
    �Ȃ�

  .OUTPUTS
    �Ȃ�

  .EXAMPLE
    PS> Start-PcDisplayOff
      PC�̃f�B�X�v���C���I�t�ɂ���

  .EXAMPLE
    PS> Start-PcDisplayOff -Help
      �w���v��\������

  .LINK
    �Q�l: Qiita�L���uPowerShell�����@�V���b�g�_�E���A�ċN���A�X���[�v�v
    https://qiita.com/Kosen-amai/items/4b773c077a588f2a2fb5
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Start-PcDisplayOff; return }

  #------------------------------
  # Main����
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
  $form = New-Object System.Windows.Forms.Form
  $message = [System.Windows.Forms.Message]::Create($form.Handle, 274, 61808, 2)
  $nativeWindow = New-Object System.Windows.Forms.NativeWindow

  Start-Sleep -Seconds 2

  $nativeWindow.DefWndProc([ref]$message)
}
# �R�}���h���b�g��Export
Export-ModuleMember -Function Start-PcDisplayOff
