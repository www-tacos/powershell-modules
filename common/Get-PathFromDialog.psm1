# $script:PT_F = 'File'
function Get-PathFromDialog {
  <#
  .SYNOPSIS
    �V�X�e���_�C�A���O��\�����ăp�X���擾����
  
  .DESCRIPTION
    �_�C�A���O��\�����A�I�����ꂽ�f�B���N�g���܂��̓t�@�C���̃p�X��Ԃ�
    �L�����Z����G�X�P�[�v�ŃA�C�e�����I������Ȃ������ꍇ�A�G���[��Ԃ�
  
  .PARAMETER Help|h
    �w���v��\������
  
  .PARAMETER PathType
    �I������p�X�̃^�C�v�i�t�@�C��/�f�B���N�g���j��I������
  
  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���
  
  .INPUTS
    �Ȃ�
  
  .OUTPUTS
    �_�C�A���O�̕\���A�I�����ꂽ�f�B���N�g���܂��̓t�@�C���̃t���p�X
  
  .EXAMPLE
    PS> Get-PathFromDialog -Help
      �w���v��\������
  
  .EXAMPLE
    PS> Get-PathFromDialog -PathType File
      �t�@�C����I������_�C�A���O��\�����A�I�����ꂽ�t�@�C���̃p�X�𓾂�
  
  .LINK
    �Q�l: ���p��
    https://buralog.jp/powershell-folderbrowserdialog/

    �Q�l: �O�ʌŒ�
    https://stackoverflow.com/questions/36714807/how-to-set-a-window-to-be-topmost-in-powershell
  #>
  Param(
    [Alias('h')][switch] $Help,
    [ValidateSet('File', 'Directory')][string] $PathType
  )
  if($Help){ Get-Help Get-PathFromDialog; return }

  #------------------------------
  # Main����
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
  switch ($PathType) {
    'File' {
      $d = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
        InitialDirectory = $env:HOMEPATH
        Title = '�t�@�C����I�����Ă�������'
        CheckFileExists = $true
        CheckPathExists = $true
        Multiselect = $false
        # Filter = '�e�L�X�g (*.txt)|*.txt'
      }
      $property = 'FileName'
    }
    'Directory' {
      $d = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{ 
        RootFolder = "MyComputer"
        Description = '�t�H���_��I�����Ă�������'
      }
      $property = 'SelectedPath'
    }
    Default {
      throw "Error: ������PathType (${PathType})"
    }
  }

  # �őO�ʌŒ�Œ����ɕ\��
  $res = $d.ShowDialog(
    (New-Object System.Windows.Forms.Form -Property @{
      TopMost = $true
      StartPosition = "CenterScreen"
    })
  )

  # �p�X�܂��̓G���[��Ԃ�
  if($res -eq [System.Windows.Forms.DialogResult]::OK) {
    return $d.$property
  } else {
    throw "�p�X���I������܂���ł���"
  }
}
# �֐������̂܂�Export����ꍇ
Export-ModuleMember -Function Get-PathFromDialog

# Alias���ݒ肵��Export����ꍇ
# Set-Alias <alias> Get-PathFromDialog
# Export-ModuleMember -Function Get-PathFromDialog -Alias <alias>
