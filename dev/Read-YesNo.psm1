function Read-YesNo {
  <#
  .SYNOPSIS
     コンソール上でYesNoダイアログを表示するコマンドレット

  .DESCRIPTION
    コンソール上に[yY/nN]をメッセージ付きで表示する
    入力を受け取りyならTrueを、nならFalseを返す

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER Message
    YesNoを確認する前のメッセージ

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    文字列

  .OUTPUTS
    真偽値

  .EXAMPLE
    PS> Read-YesNo
      コンソールに「Yes or No [yY/nN]」を表示し入力を受け付ける

  .EXAMPLE
    PS> Read-YesNo -Help
      ヘルプを表示する

  .EXAMPLE
    PS> Read-YesNo -Message "対応しますか？"
      コンソールに「対応しますか？ [yY/nN]」を表示し入力を受け付ける
  #>
  Param(
    [Alias('h')][switch] $Help,
    [string] $Message = "Yes or No"
  )
  if ($Help) { Get-Help Read-YesNo; return }

  #------------------------------
  # Main処理
  #------------------------------
  Write-Host "${Message} [yY/nN]"
  while ($True) {
    Write-Host ">> " -NoNewLine
    $yn = Read-Host
    if ($yn -match "^[yYnN]$") {
      break
    }
    else {
      Write-Host "無効な入力です [${yn}]`n"
      continue
    }
  }
  return ($yn -match "^[yY]$")
}
# コマンドレットをExport
Export-ModuleMember -Function Read-YesNo
