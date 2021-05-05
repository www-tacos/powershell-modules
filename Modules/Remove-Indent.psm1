function Remove-Indent {
  <#
  .SYNOPSIS
  �C���f���g�̍폜
  
  .DESCRIPTION
  �q�A�h�L�������g�ɋϓ��ɃC���f���g���܂߂Ă���ꍇ�A���̃C���f���g����������
  ���ׂĂ̍s�̒���1�ԒZ���C���f���g��S�s�����菜��
  
  .EXAMPLE
  PS> Remove-Indent $txt
  String�^�̒l�������ɂƂ�
  
  .LINK
  �֘A���郊���N�� URL
  https://stackoverflow.com/questions/1417663/doing-textwrap-and-dedent-in-windows-powershell-or-dotnet-aka-net
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $text
  )
  if($Help){ Get-Help Remove-Indent; return }

  ##### WRITE CODE HERE #####
  $strArray = $str.Split("`n");
  $i = $strArray | ForEach-Object {
    $_ -match "^(\s*)" |
    Out-Null ; $Matches[1].Length
  } | Sort-Object | Select-Object -First 1
  $text -replace "^\s{$i}" | ForEach-Object -Begin { $tmp = '' } { $tmp += "$_`n" } -End { return $tmp }
}
Export-ModuleMember -Function Remove-Indent
