function Remove-BOM {
  <#
  .SYNOPSIS
    BOM�t��UTF-8�̃t�@�C����UTF-8�ɕϊ�����

  .DESCRIPTION
    BOM�t��UTF-8�̃t�@�C������BOM���폜��UTF-8�t�@�C���ɕϊ�����

  .PARAMETER Help|h
    �w���v��\������

  .PARAMETER FilePath
    BOM�t��UTF-8�̃t�@�C��

  .PARAMETER CommonParameters
    �T�|�[�g���Ă��܂���

  .INPUTS
    �t�@�C���p�X

  .OUTPUTS
    �ϊ��t�@�C��

  .EXAMPLE
    PS> Remove-BOM -Help
      �w���v��\������

  .EXAMPLE
    PS> Remove-BOM -Path ~/Downloads/sample_utf8bom.txt
      BOM�Ȃ���UTF-8�`���� ~/Downloads/sample_utf8bom.txt ���㏑������

  .EXAMPLE
    PS> Remove-BOM -Path ~/Downloads/sample_utf8bom.txt -BackUp
      BOM�Ȃ���UTF-8�`���� ~/Downloads/sample_utf8bom.txt ���㏑������
      ���̃t�@�C���� ~/Downloads/sample_utf8bomk.yyyymmdd_hhmmss.txt �Ńo�b�N�A�b�v����

  .LINK
    �Q�l: <�Q�l�T�C�g�T�v>
    <URL>
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $FilePath,
    [switch] $BackUp
  )
  if($Help){ Get-Help Remove-BOM; return }

  #------------------------------
  # Main����
  #------------------------------
  if(-not (Test-Path $FilePath -PathType Leaf)) {
    throw "Error: �t�@�C�����w�肵�Ă��������B�i${FilePath}�j"
  }
  if($BackUp) {
    $_f = Get-Item $FilePath
    $_ts = (Get-Date).ToString("yyyyMMdd_HHmmss")
    $_bkup = "$($_f.DirectoryName)/$($_f.BaseName)_${_ts}$($_f.Extension)"
    Copy-Item $_f $_bkup
  }
  $text = Get-Content $FilePath
  $UTF8_NO_BOM_ENCODING = New-Object System.Text.UTF8Encoding($False)
  [System.IO.File]::WriteAllLines($FilePath, $text, $UTF8_NO_BOM_ENCODING)
}
# �R�}���h���b�g��Export
Export-ModuleMember -Function Remove-BOM
