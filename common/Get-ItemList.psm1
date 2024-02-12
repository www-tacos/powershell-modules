function Get-ItemList {
  <#
  .SYNOPSIS
    �w��p�X�̃A�C�e����\������

  .DESCRIPTION
    Bash��ls�R�}���h�̂悤�Ɏw��p�X�̃A�C�e�����݂̂�\������
    �f�t�H���g�ł̓R���\�[���֕\������ݒ�ŁA���̏ꍇ�͐F�t���ŕ\������
    ���_�C���N�g���[�h�ɂ����ꍇ�� Get-ChildItem ���w��p�X�ɑ΂��Ď��s�������ʂ�Ԃ�

  .PARAMETER Help|h
    �w���v��\������

  .PARAMETER Path
    �A�C�e�����X�g��\������Ώۂ̃p�X
    �f�B���N�g�����w�肵���ꍇ�̓f�B���N�g�����̃A�C�e������ΏۂƂ���
    �t�@�C�����w�肵���ꍇ�͂��̃t�@�C������ΏۂƂ���

  .PARAMETER Redirect
    ���_�C���N�g���[�h�̃X�C�b�`
    �f�t�H���g�̓I�t
    �I�t�̏ꍇ�� Write-Host ��p���ăR���\�[���֕\�����邽�߃��_�C���N�g���s�\
    �I���ɂ����ꍇ�̓I�u�W�F�N�g��Ԃ��̂Ń��_�C���N�g�\

    .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���

  .INPUTS
    �p�X������

  .OUTPUTS
    �Ȃ��A�������̓I�u�W�F�N�g�z��

  .EXAMPLE
    PS> Get-ItemList
      �J�����g�f�B���N�g���̒��g��\������

  .EXAMPLE
    PS> Get-ItemList -Help
      �w���v��\������

  .EXAMPLE
    PS> Get-ItemList ~/
      �z�[���f�B���N�g���̒��g�̕\��

  .EXAMPLE
    PS> Get-ItemList ~/Downloads/hoge.txt
      �t�@�C�����̕\��

  .EXAMPLE
    PS> Get-ItemList ~/ -Redirect
      �z�[���f�B���N�g���̒��g�̔z��̕ԋp

  .LINK
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $Path = (Get-Location).Path,
    [switch] $Redirect = $false
  )
  if($Help){ Get-Help Get-ItemList; return }

  #------------------------------
  # Main����
  #------------------------------
  # Redirect �̏ꍇ�� Get-ChildItem �̌��ʂ����̂܂ܕԂ�
  if($Redirect) {
    return Get-ChildItem $Path
  }

  # �F�̐ݒ�
  $ColorFile = [System.ConsoleColor]::Green
  $ColorDirectory = [System.ConsoleColor]::Cyan

  # �\����̋�؂蕶��
  $SEPARATOR = " " * 6

  # TODO: �R���\�[�������擾���ēr�����s��h���ꍇ�͈ȉ����g��
  # $maxWidth = $Host.UI.RawUI.WindowSize.Width

  Get-ChildItem $Path | ForEach-Object {
    if(Test-Path $_ -PathType Container) {
      # �ΏۃA�C�e���� Directory �̏ꍇ
      Write-Host -NoNewline $_.Name -Foreground $ColorDirectory
    } else {
      # �ΏۃA�C�e���� File �̏ꍇ
      Write-Host -NoNewline $_.Name -Foreground $ColorFile
    }
    # ��؂蕶���̕\��
    Write-Host -NoNewline $SEPARATOR
  }
}
# �R�}���h���b�g��Export
Export-ModuleMember -Function Get-ItemList
