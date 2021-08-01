function Invoke-Scrcpy {
  <#
  .SYNOPSIS
    Scrcpy�̃��b�p�[�R�}���h

  .DESCRIPTION
    Scrcpy�̊e��I�v�V������Θb�`���ŏ����ݒ肵�Ă������b�p�[�R�}���h

  .PARAMETER Help|h
    �w���v��\������

  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���

  .INPUTS
    �Θb�`���Ŋe��I�v�V�����l���󂯎��

  .OUTPUTS
    �w�肳�ꂽ�I�v�V������scrcpy�����s����

  .EXAMPLE
    PS> Invoke-Scrcpy
      �Θb���[�h���J�n����

  .EXAMPLE
    PS> Invoke-Scrcpy -Help
      �w���v��\������

  .LINK
    �Q�l: Scrcpy �������|�W�g��
    https://github.com/Genymobile/scrcpy
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Invoke-Scrcpy; return }

  #------------------------------
  # Main����
  #------------------------------
  $scrcpy = 'scrcpy.exe'
  # scrcpy�R�}���h�����ϐ��ɐݒ肳��Ă��Ȃ���ΏI��
  try {
    Get-Command $scrcpy > $null
  }
  catch {
    Write-Output "Error: ${scrcpy} is not find"
    Write-Output "Please set ${scrcpy} to environmental parameter"
    return
  }

  function getParam {
    param (
      [int] $id,
      [String] $title,
      [String] $desc,
      [String] $pattern
    )
    while ($true) {
      Write-Host "`n--------------------------------------------------"
      Write-Host "${id}. ${title}"
      Write-Host "    �ڍׁ@�@ : ${desc}"
      Write-Host "    ���͋K�� : ${pattern}"
      Write-Host "    �i�w�肵�Ȃ��ꍇ�͉������͂�����Enter�j"
      $read = Read-Host -Prompt '����'
      if($read -eq '' -or $read -match $pattern) {
        return ${read}
      } else {
        Write-Host -NoNewline "�����ȓ��͂ł��B�ē��͂��Ă��������B" -ForegroundColor Red
        continue
      }
    }
  }

  $command = "${scrcpy}"
  [int] $i = 0

  $bitrate = getParam `
    (++$i) `
    "�r�b�g���[�g [bps]" `
    "���l�܂��͒P�ʕt�����l�œ��́i8000000, 8M, 8m�j" `
    "^[1-9][0-9]*[kKmM]?$"
  if($bitrate) {
    $command += " -b${bitrate}"
  }

  $maxsize = getParam `
    (++$i) `
    "���ӂ̒��� [px]" `
    "���l�œ��́i�Z�ӂ͎����Z�o�����j" `
    "^[1-9][0-9]*$"
  if($maxsize) {
    $command += " -m${maxsize}"
  }

  $maxfps = getParam `
    (++$i) `
    "�ő�t���[�����[�g [fps]" `
    "���l�œ���" `
    "^[1-9][0-9]*$"
  if($maxfps) {
    $command += " --max-fps ${maxfps}"
  }

  $fullscreen = getParam `
    (++$i) `
    "�t���X�N���[���̗L��" `
    "Bool�l�œ���" `
    "^[tT]rue|[fF]alse$"
  if($fullscreen) {
    $command += " -f"
  }

  # Invoke-Expression $command
  Write-Output $command
}
# �֐������̂܂�Export����ꍇ
Export-ModuleMember -Function Invoke-Scrcpy

# Alias���ݒ肵��Export����ꍇ
# Set-Alias <alias> Invoke-Scrcpy
# Export-ModuleMember -Function Invoke-Scrcpy -Alias <alias>
