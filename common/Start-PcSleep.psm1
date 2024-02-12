function Start-PcSleep {
  <#
  .SYNOPSIS
    PC���X���[�v��Ԃɂ���

  .DESCRIPTION
    PC���X���[�v��Ԃɂ���

  .PARAMETER Help|h
    �w���v��\������

  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���

  .INPUTS
    �Ȃ�

  .OUTPUTS
    �Ȃ�

  .EXAMPLE
    PS> Start-PcSleep
      PC���X���[�v������

  .EXAMPLE
    PS> Start-PcSleep -Help
      �w���v��\������

  .LINK
    �Q�l: Qiita�L���uPowerShell�����@�V���b�g�_�E���A�ċN���A�X���[�v�v
    https://qiita.com/Kosen-amai/items/4b773c077a588f2a2fb5
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Start-PcSleep; return }

  #------------------------------
  # Main����
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
  $state = [System.Windows.Forms.PowerState]::Suspend
  $force = $true
  $disableWakeEvent = $false
  [System.Windows.Forms.Application]::SetSuspendState($state, $force, $disableWakeEvent)
}
# �R�}���h���b�g��Export
Export-ModuleMember -Function Start-PcSleep
