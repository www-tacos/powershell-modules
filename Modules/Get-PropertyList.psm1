function Get-PropertyList {
  <#
  .SYNOPSIS
  �I�u�W�F�N�g�����v���p�e�B�\�ꗗ���擾����
  
  .DESCRIPTION
  �p�����[�^�̃I�u�W�F�N�g�����v���p�e�B�\�ꗗ�̔z��I�u�W�F�N�g���擾����
  
  .EXAMPLE
  PS> Get-PropertyList (Get-Date)
  DateTime�I�u�W�F�N�g�����v���p�e�B�\�ꗗ���擾����
  
  .EXAMPLE
  Get-Date | Get-PropertyList
  �p�C�v���C���œn�����Ƃ��\
  
  PARAMETER �ɂ� CommonParameters �ɂ��Đ���������ɒǉ������̂�
  �u<CommonParameters> �̓T�|�[�g���Ă��܂���v�Ə����Ă����Ɨǂ���������܂���B
  
  .LINK
  ���ɂȂ�
  #>
  Param(
    [Alias('h')][switch] $Help,
    [Parameter(ValueFromPipeline=$true)][object] $InputObject
  )
  if($Help){ Get-Help Get-PropertyList; return }

  class Record {
    [string]$key
    [string]$value
    Record([string]$k, [string]$v) {
        $this.key = $k
        $this.value = $v
    }
  }
  $res = @()
  Get-Member -InputObject $InputObject -MemberType property | ForEach-Object {
      $res += [Record]::new($_.Name, $InputObject.($_.Name))
  }
  return $res
}
Export-ModuleMember -Function Get-PropertyList
