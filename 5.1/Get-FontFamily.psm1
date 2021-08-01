function Get-FontFamily {
<#
.SYNOPSIS
Font Family �ꗗ���擾����

.DESCRIPTION
Font Family �̈ꗗ���擾���A�e�t�H���g�̃T���v�����܂Ƃ߂�HTML�t�@�C�����쐬���ĕ\������
�쐬����HTML�t�@�C���̓u���E�U�N����10�b��ɏ�������i�u���E�U�̓L���b�V����\����������j

.LINK
�Q�l�����N
http://itemy.net/?p=729
#>

  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Get-FontFamily; return; }

  [void][reflection.assembly]::LoadWithPartialName("System.Drawing")
  $TableText = "<table>"
  $TableText += "<thead><tr><th>Font Family</th><th>�T���v������</th></tr></thead><tbody>"
  [System.Drawing.FontFamily]::Families | ForEach-Object {
      $fn = $_.Name
      $TableText += "<tr><td>${fn}</td><td style=`"font-size:20px; font-family:${fn}`">�t�H���g�̃T���v���\��ABCDEF0123456789</td></tr>"
  }
  $TableText += "</tbody></table>"
  $HtmlText = @"
<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="Shift_JIS">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Font Family List</title>
  </head>
  <body>
  ${TableText}
  </body>
</html>
"@
  $HtmlFile = "${env:HOMEPATH}/temp_font-family.html"
  Write-Output $HtmlText | Out-File -FilePath $HtmlFile -Encoding default
  Invoke-Item $HtmlFile
  Start-Sleep -Seconds 10
  Remove-Item -Path $HtmlFile -Force
}
Export-ModuleMember -Function Get-FontFamily
