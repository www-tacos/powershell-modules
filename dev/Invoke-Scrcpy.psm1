function Invoke-Scrcpy {
  <#
  .SYNOPSIS
    Scrcpyのラッパーコマンド

  .DESCRIPTION
    Scrcpyの各種オプションを対話形式で順次設定していくラッパーコマンド

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    対話形式で各種オプション値を受け取る

  .OUTPUTS
    指定されたオプションでscrcpyを実行する

  .EXAMPLE
    PS> Invoke-Scrcpy
      対話モードを開始する

  .EXAMPLE
    PS> Invoke-Scrcpy -Help
      ヘルプを表示する

  .LINK
    参考: Scrcpy 公式リポジトリ
    https://github.com/Genymobile/scrcpy
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if ($Help) { Get-Help Invoke-Scrcpy; return }

  #------------------------------
  # Main処理
  #------------------------------
  $scrcpy = 'scrcpy.exe'
  # scrcpyコマンドが環境変数に設定されていなければ終了
  try {
    Get-Command $scrcpy > $null
  }
  catch {
    Write-Output "Error: ${scrcpy} is not find"
    Write-Output "Please set ${scrcpy} to environmental parameter"
    return
  }

  function getParam {
    param (
      [int] $id,
      [String] $title,
      [String] $desc,
      [String] $pattern
    )
    while ($true) {
      Write-Host "`n--------------------------------------------------"
      Write-Host "${id}. ${title}"
      Write-Host "    詳細　　 : ${desc}"
      Write-Host "    入力規則 : ${pattern}"
      Write-Host "    （指定しない場合は何も入力せずにEnter）"
      $read = Read-Host -Prompt '入力'
      if ($read -eq '' -or $read -match $pattern) {
        return ${read}
      }
      else {
        Write-Host -NoNewline "無効な入力です。再入力してください。" -ForegroundColor Red
        continue
      }
    }
  }

  $command = "${scrcpy}"
  [int] $i = 0

  $bitrate = getParam `
  (++$i) `
    "ビットレート [bps]" `
    "数値または単位付き数値で入力（8000000, 8M, 8m）" `
    "^[1-9][0-9]*[kKmM]?$"
  if ($bitrate) {
    $command += " -b${bitrate}"
  }

  $maxsize = getParam `
  (++$i) `
    "長辺の長さ [px]" `
    "数値で入力（短辺は自動算出される）" `
    "^[1-9][0-9]*$"
  if ($maxsize) {
    $command += " -m${maxsize}"
  }

  $maxfps = getParam `
  (++$i) `
    "最大フレームレート [fps]" `
    "数値で入力" `
    "^[1-9][0-9]*$"
  if ($maxfps) {
    $command += " --max-fps ${maxfps}"
  }

  $fullscreen = getParam `
  (++$i) `
    "フルスクリーンの有無" `
    "Bool値で入力" `
    "^[tT]rue|[fF]alse$"
  if ($fullscreen) {
    $command += " -f"
  }

  # Invoke-Expression $command
  Write-Output $command
}
# コマンドレットをExport
Export-ModuleMember -Function Invoke-Scrcpy
