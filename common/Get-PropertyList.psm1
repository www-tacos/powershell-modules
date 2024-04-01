function Get-PropertyList {
  <#
  .SYNOPSIS
  オブジェクトが持つプロパティ―一覧を取得する

  .DESCRIPTION
  パラメータのオブジェクトが持つプロパティ―一覧の配列オブジェクトを取得する

  .EXAMPLE
  PS> Get-PropertyList (Get-Date)
  DateTimeオブジェクトが持つプロパティ―一覧を取得する

  .EXAMPLE
  Get-Date | Get-PropertyList
  パイプラインで渡すことも可能

  PARAMETER には CommonParameters について説明が勝手に追加されるので
  「<CommonParameters> はサポートしていません」と書いておくと良いかもしれません。

  .LINK
  特になし
  #>
  Param(
    [Alias('h')][switch] $Help,
    [Parameter(ValueFromPipeline = $true)][object] $InputObject
  )
  if ($Help) { Get-Help Get-PropertyList; return }

  class Record {
    [string]$key
    [string]$value
    Record([string]$k, [string]$v) {
      $this.key = $k
      $this.value = $v
    }
  }
  $res = @()
  Get-Member -InputObject $InputObject -MemberType property | ForEach-Object {
    $res += [Record]::new($_.Name, $InputObject.($_.Name))
  }
  return $res
}
Export-ModuleMember -Function Get-PropertyList
