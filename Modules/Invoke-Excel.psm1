function Invoke-Excel {
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
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Invoke-Excel; return }

  ##### WRITE CODE HERE #####
}
Export-ModuleMember -Function Invoke-Excel



<#
function Invoke-Excel {
    Param(
        [switch]$IsReadOnly = $false
    )
    $FilePaths = $args | % { (Get-ChildItem $_).FullName }
    $EXCEL = 'C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE'
    if ($FilePaths.Length -eq 0) {
        Start-Process -FilePath $EXCEL
    } else {
        if($IsReadOnly) {$FilePaths = @("/r") + $FilePaths}
        Start-Process -FilePath $EXCEL -ArgumentList $FilePaths
    }
}
#>