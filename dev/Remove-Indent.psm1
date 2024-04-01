function Remove-Indent {
  <#
  .SYNOPSIS
  インデントの削除

  .DESCRIPTION
  ヒアドキュメントに均等にインデントを含めている場合、そのインデントを消去する
  すべての行の中で1番短いインデントを全行から取り除く

  .EXAMPLE
  PS> Remove-Indent $txt
  String型の値を引数にとる

  .LINK
  関連するリンクの URL
  https://stackoverflow.com/questions/1417663/doing-textwrap-and-dedent-in-windows-powershell-or-dotnet-aka-net
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $Text
  )
  if ($Help) { Get-Help Remove-Indent; return }

  ##### WRITE CODE HERE #####
  $strArray = $Text.Split("`n");
  $i = $strArray | ForEach-Object {
    $_ -match "^(\s*)" |
    Out-Null ; $Matches[1].Length
  } | Sort-Object | Select-Object -First 1
  $Text -replace "^\s{$i}" | ForEach-Object -Begin { $tmp = '' } { $tmp += "$_`n" } -End { return $tmp }
}
Export-ModuleMember -Function Remove-Indent
