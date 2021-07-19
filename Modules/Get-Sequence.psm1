function Get-Sequence {
  <#
  .SYNOPSIS
    Bash��seq���R�}���h

  .DESCRIPTION
    �C�ӂ̃X�e�b�v���̏���z���Ԃ�
    �f�t�H���g�̃X�e�b�v����1

  .PARAMETER Help|h
    �w���v��\������

  .PARAMETER Start
    ����̎n�܂�̒l�i����Ɋ܂܂��j
    �f�t�H���g��0

    .PARAMETER End
    ����̏I���̒l�i����Ɋ܂܂��j
    �f�t�H���g��0

  .PARAMETER Step
    ����̑�����
    �f�t�H���g��1

  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���

  .INPUTS
    �����̂݃T�|�[�g�B�����̏ꍇ��int�ɃL���X�g�����i�l�̌ܓ��j
    ���̐����T�|�[�g
    Start��End��菬�����ꍇ�͍~���̐���ɂȂ�

  .OUTPUTS
    int�z��I�u�W�F�N�g

  .EXAMPLE
    PS> Get-Sequence
      0 ��Ԃ�

  .EXAMPLE
    PS> Get-Sequence -Help
      �w���v��\������

  .EXAMPLE
    PS> Get-Sequence 1 3
      �z�� {1,2,3} ��Ԃ�

  .EXAMPLE
    PS> Get-Sequence 1 5 2
      �z�� {1,3,5} ��Ԃ�

  .EXAMPLE
    PS> Get-Sequence 5 -5 3
      �z�� {5,2,-1,-4} ��Ԃ�

  .LINK
    �Q�l: PowerShell�ł̏���̍쐬
    https://stackoverflow.com/questions/34028471/powershell-number-sequencing
  #>
  Param(
    [Alias('h')][switch] $Help,
    [int] $Start = 0,
    [int] $End = 0,
    [int] $Step = 1
  )
  if($Help){ Get-Help Get-Sequence; return }

  #------------------------------
  # Main����
  #------------------------------
  return ${Start}..${End} |
  ForEach-Object -Begin {
    $i = 0
    $res = @()
  } -Process {
    if($i % ${Step} -eq 0) {
      ${res} += $_
    }
    $i += 1
  } -End {
    return ${res}
  }
}
# �֐������̂܂�Export����ꍇ
# Export-ModuleMember -Function Get-Sequence

# Alias���ݒ肵��Export����ꍇ
Set-Alias seq Get-Sequence
Export-ModuleMember -Function Get-Sequence -Alias seq
