function Set-ExcelDefaultOption {
  <#
  .SYNOPSIS
    �G�N�Z���̃f�t�H���g�̋N�����[�h��ύX����
  
  .DESCRIPTION
    �֘A�t����Excel�ɂȂ��Ă���t�@�C���^�C�v�ɑ΂��ċN�����̃R�}���h�ɃI�v�V������t���ċN�����[�h��ύX����
    ftype�����s���邽�߂ɊǗ��Ҍ����ŃR�}���h�����s����K�v������
  
  .PARAMETER Help|h
    �w���v��\������
  
  .PARAMETER IsReadOnly
    �u�b�N��ǂݎ���p�ŊJ���悤�ɂ���
  
  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���
  
  .INPUTS
    �I�v�V�����̎w��
  
  .OUTPUTS
    �Ȃ��BExcel�̋N�����̋�����ύX����
  
  .EXAMPLE
    PS> Set-ExcelDefaultOption
      Excel���J�����Ƃ��̋������f�t�H���g�ɂ���
  
  .EXAMPLE
    PS> Set-ExcelDefaultOption -Help
      �w���v��\������
  
  .EXAMPLE
    PS> Set-ExcelDefaultOption -IsReadOnly
      Excel���J�����Ƃ��̋�����ǂݎ���p�ɂ���
  
  .LINK
    �Q�l: Microsoft Office ���i�̃R�}���h ���C�� �X�C�b�`
    https://support.microsoft.com/ja-jp/office/microsoft-office-%E8%A3%BD%E5%93%81%E3%81%AE%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89-%E3%83%A9%E3%82%A4%E3%83%B3-%E3%82%B9%E3%82%A4%E3%83%83%E3%83%81-079164cd-4ef5-4178-b235-441737deb3a6#ID0EAABAAA=Excel
  #>
  Param(
    [Alias('h')][switch] $Help,
    [switch] $IsReadOnly = $false
  )
  if($Help){ Get-Help Set-ExcelDefaultOption; return }

  #------------------------------
  # Main����
  #------------------------------
  # �Ǘ��Ҍ����̗L���m�F
  $CurrentRole = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
  $AdminRole = [Security.Principal.WindowsBuiltInRole] "Administrator"
  if (-not ($CurrentRole.IsInRole($AdminRole))) {
    throw "Error: �Ǘ��Ҍ����ł̎��s���K�v�ł��B"
  }

  # option�̐ݒ�
  $options = ''
  if($IsReadOnly) { $options += ' /r' }

  # �t�@�C���֘A�t���̑S�擾
  $chg_cnt = (
    cmd /c assoc | Where-Object {
      # �t�@�C���^�C�v�ɁuExcel�v���܂ފ֘A�t���𒊏o�i�啶������������ʁj
      $_ -clike '*Excel*'
    } | ForEach-Object {
      # �t�@�C���^�C�v�����𒊏o
      $_.Split('=')[1]
    } | ForEach-Object {
      # �t�@�C���^�C�v�Ɋ֘A�Â��R�}���h���擾�i�G���[�͖����j
      cmd /c ftype $_ 2>$null
    } | ForEach-Object {
      # �t�@�C���^�C�v�ƃR�}���h�̋��
      $ftype, $cmd = $_.Split('=')
      # ���s�t�@�C���̃t���p�X�擾
      $exe = [Regex]::Matches($cmd, '("[^"]*")')[0].Value
      # �t�@�C���^�C�v�ɕR�Â��R�}���h�̕ύX
      cmd /c "ftype ${ftype}=${exe}${options} `"%1`""
    }
  )

  # �֘A�t���ύX�Ώۂ�0���̏ꍇ��Excel���C���X�g�[������Ă��Ȃ����ʂ̃A�v�����֘A�t������Ă���
  if($chg_cnt -eq 0) {
    Write-Warning "Excel�A�v���ɕR�Â��g���q������܂���ł����BExcel���C���X�g�[������Ă��Ȃ����ʂ̃A�v���P�[�V�������֘A�t������Ă���\��������܂��B"
  }
}
# �֐������̂܂�Export����ꍇ
Export-ModuleMember -Function Set-ExcelDefaultOption

# Alias���ݒ肵��Export����ꍇ
# Set-Alias <alias> Set-ExcelDefaultOption
# Export-ModuleMember -Function Set-ExcelDefaultOption -Alias <alias>
