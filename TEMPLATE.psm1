function TemplateModule {
<#
.SYNOPSIS
�����ɊT�v�������܂�

.DESCRIPTION
�����ɐ����������܂�

.EXAMPLE
�����ɋ�̓I�Ȉ����̗�Ɖ���������܂�(�����L�q��)

.EXAMPLE
�����ɋ�̓I�Ȉ����̗�Ɖ���������܂�(�����L�q��)

.PARAMETER ������
����������̐����������܂�(�����L�q��)

.PARAMETER ������
����������̐����������܂�(�����L�q��)

PARAMETER �ɂ� CommonParameters �ɂ��Đ���������ɒǉ������̂�
�u<CommonParameters> �̓T�|�[�g���Ă��܂���v�Ə����Ă����Ɨǂ���������܂���B

.LINK
�֘A���郊���N�� URL �������܂�
http://www.vwnet.jp/Windows/PowerShell/SupportGetHelp.htm
https://docs.microsoft.com/ja-jp/powershell/scripting/developer/module/how-to-write-a-powershell-script-module?view=powershell-7.1#show-calendar-code-example
#>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help TemplateModule; return }

  # write code below
}

Export-ModuleMember -Function TemplateModule
