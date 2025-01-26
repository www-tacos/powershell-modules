function Invoke-Excel {
  <#
  .SYNOPSIS
  ここに概要を書きます

  .DESCRIPTION
  ここに説明を書きます

  .EXAMPLE
  ここに具体的な引数の例と解説を書きます(複数記述可)

  .EXAMPLE
  ここに具体的な引数の例と解説を書きます(複数記述可)

  .PARAMETER 引数名
  ここら引数の説明を書きます(複数記述可)

  .PARAMETER 引数名
  ここら引数の説明を書きます(複数記述可)

  PARAMETER には CommonParameters について説明が勝手に追加されるので
  「<CommonParameters> はサポートしていません」と書いておくと良いかもしれません。

  .LINK
  関連するリンクの URL を書きます
  http://www.vwnet.jp/Windows/PowerShell/SupportGetHelp.htm
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if ($Help) { Get-Help Invoke-Excel; return }

  ##### WRITE CODE HERE #####
}
Export-ModuleMember -Function Invoke-Excel



<#
function Invoke-Excel {
    Param(
        [switch]$IsReadOnly = $false
    )
    $FilePaths = $args | % { (Get-ChildItem $_).FullName }
    $EXCEL = 'C:\Program Files\Microsoft Office\root\Office16\EXCEL.EXE'
    if ($FilePaths.Length -eq 0) {
        Start-Process -FilePath $EXCEL
    } else {
        if($IsReadOnly) {$FilePaths = @("/r") + $FilePaths}
        Start-Process -FilePath $EXCEL -ArgumentList $FilePaths
    }
}
#>
