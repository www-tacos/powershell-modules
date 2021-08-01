function Get-Sequence {
  <#
  .SYNOPSIS
    Bashのseq風コマンド

  .DESCRIPTION
    任意のステップ数の順列配列を返す
    デフォルトのステップ数は1

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER Start
    順列の始まりの値（順列に含まれる）
    デフォルトは0

    .PARAMETER End
    順列の終わりの値（順列に含まれる）
    デフォルトは0

  .PARAMETER Step
    順列の増加量
    デフォルトは1

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    整数のみサポート。少数の場合はintにキャストされる（四捨五入）
    負の数もサポート
    StartがEndより小さい場合は降順の数列になる

  .OUTPUTS
    int配列オブジェクト

  .EXAMPLE
    PS> Get-Sequence
      0 を返す

  .EXAMPLE
    PS> Get-Sequence -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Get-Sequence 1 3
      配列 {1,2,3} を返す

  .EXAMPLE
    PS> Get-Sequence 1 5 2
      配列 {1,3,5} を返す

  .EXAMPLE
    PS> Get-Sequence 5 -5 3
      配列 {5,2,-1,-4} を返す

  .LINK
    参考: PowerShellでの順列の作成
    https://stackoverflow.com/questions/34028471/powershell-number-sequencing
  #>
  Param(
    [Alias('h')][switch] $Help,
    [int] $Start = 0,
    [int] $End = 0,
    [int] $Step = 1
  )
  if($Help){ Get-Help Get-Sequence; return }

  #------------------------------
  # Main処理
  #------------------------------
  return ${Start}..${End} |
  ForEach-Object -Begin {
    $i = 0
    $res = @()
  } -Process {
    if($i % ${Step} -eq 0) {
      ${res} += $_
    }
    $i += 1
  } -End {
    return ${res}
  }
}
# 関数をそのままExportする場合
# Export-ModuleMember -Function Get-Sequence

# Aliasも設定してExportする場合
Set-Alias seq Get-Sequence
Export-ModuleMember -Function Get-Sequence -Alias seq
