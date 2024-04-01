function Get-ComObjectList {
  <#
  .SYNOPSIS
  Com Object 一覧の取得

  .DESCRIPTION
  New-Objectコマンドの-ComObjectに指定可能なパラメータ一覧を取得する
  -ComObject使用例
    PS> $excel = New-Object -ComObject Excel.Application

  .EXAMPLE
  PS> Get-ComObjectList
  コンソール上に一覧を表示

  .EXAMPLE
  PS> Get-ComObjectList | Where-Object { $_ -like "*excel*" }
  excel でフィルタリングした結果のみ表示

  .EXAMPLE
  PS> Get-ComObjectList | Out-File -FilePath ./com-objects.txt -Encoding default
  ファイル出力

  .LINK
  参考リンク
  https://www.powershellmagazine.com/2013/06/27/pstip-get-a-list-of-all-com-objects-available/
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if ($Help) { Get-Help Get-ComObjectList; return }

  ##### WRITE CODE HERE #####
  return Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
  } | Select-Object -ExpandProperty PSChildName
}
Export-ModuleMember -Function Get-ComObjectList
