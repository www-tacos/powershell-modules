function TemplateModule {
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
https://docs.microsoft.com/ja-jp/powershell/scripting/developer/module/how-to-write-a-powershell-script-module?view=powershell-7.1#show-calendar-code-example
#>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help TemplateModule; return }

  # write code below
}

Export-ModuleMember -Function TemplateModule
