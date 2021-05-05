function Set-DebugPreference {
  <#
  .SYNOPSIS
  �f�o�b�O���[�h�̐ݒ�
  
  .DESCRIPTION
  �f�o�b�O���[�h��ݒ肷��
  �f�t�H���g�ł� SilentlyContinue �ɐݒ肳��Ă���
  �^�u�⊮�Ńf�o�b�O���[�h��ݒ�\
  
  .EXAMPLE
  PS> Set-DebugPreference -Mode Continue
  �f�o�b�O���[�h�� Continue �ɐݒ肷��
  
  .EXAMPLE
  PS> Set-DebugPreference
  �f�o�b�O���[�h���f�t�H���g�ɖ߂�
  
  PARAMETER �ɂ� CommonParameters �ɂ��Đ���������ɒǉ������̂�
  �u<CommonParameters> �̓T�|�[�g���Ă��܂���v�Ə����Ă����Ɨǂ���������܂���B
  
  .LINK
  �֘A���郊���N�� URL �������܂�
  https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Core/About/about_Preference_Variables?view=powershell-7.1#debugpreference
  #>
  Param(
    [Alias('h')][switch] $Help,
    [ValidateSet(
      "SilentlyContinue",  # �����Ȃ�
      "Continue",  # Write-Debug��\�����ď�����i�߂�
      "Inquire",  # Write-Debug��\�����ď�����i�߂邩����
      "Stop"  # Write-Debug��\�����ď������~�߂�
    )][string] $Mode = "SilentlyContinue"
  )
  if($Help){ Get-Help Set-DebugPreference; return }

  $Global:DebugPreference = $Mode
}
Export-ModuleMember -Function Set-DebugPreference
