function Set-ExcelDefaultOption {
  <#
  .SYNOPSIS
    エクセルのデフォルトの起動モードを変更する
  
  .DESCRIPTION
    関連付けがExcelになっているファイルタイプに対して起動時のコマンドにオプションを付けて起動モードを変更する
    ftypeを実行するために管理者権限でコマンドを実行する必要がある
  
  .PARAMETER Help|h
    ヘルプを表示する
  
  .PARAMETER IsReadOnly
    ブックを読み取り専用で開くようにする
  
  .PARAMETER CommonParameters
    サポートしていません
  
  .INPUTS
    オプションの指定
  
  .OUTPUTS
    なし。Excelの起動時の挙動を変更する
  
  .EXAMPLE
    PS> Set-ExcelDefaultOption
      Excelを開いたときの挙動をデフォルトにする
  
  .EXAMPLE
    PS> Set-ExcelDefaultOption -Help
      ヘルプを表示する
  
  .EXAMPLE
    PS> Set-ExcelDefaultOption -IsReadOnly
      Excelを開いたときの挙動を読み取り専用にする
  
  .LINK
    参考: Microsoft Office 製品のコマンド ライン スイッチ
    https://support.microsoft.com/ja-jp/office/microsoft-office-%E8%A3%BD%E5%93%81%E3%81%AE%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89-%E3%83%A9%E3%82%A4%E3%83%B3-%E3%82%B9%E3%82%A4%E3%83%83%E3%83%81-079164cd-4ef5-4178-b235-441737deb3a6#ID0EAABAAA=Excel
  #>
  Param(
    [Alias('h')][switch] $Help,
    [switch] $IsReadOnly = $false
  )
  if($Help){ Get-Help Set-ExcelDefaultOption; return }

  #------------------------------
  # Main処理
  #------------------------------
  # 管理者権限の有無確認
  $CurrentRole = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
  $AdminRole = [Security.Principal.WindowsBuiltInRole] "Administrator"
  if (-not ($CurrentRole.IsInRole($AdminRole))) {
    throw "Error: 管理者権限での実行が必要です。"
  }

  # optionの設定
  $options = ''
  if($IsReadOnly) { $options += ' /r' }

  # ファイル関連付けの全取得
  $chg_cnt = (
    cmd /c assoc | Where-Object {
      # ファイルタイプに「Excel」を含む関連付けを抽出（大文字小文字を区別）
      $_ -clike '*Excel*'
    } | ForEach-Object {
      # ファイルタイプ部分を抽出
      $_.Split('=')[1]
    } | ForEach-Object {
      # ファイルタイプに関連づくコマンドを取得（エラーは無視）
      cmd /c ftype $_ 2>$null
    } | ForEach-Object {
      # ファイルタイプとコマンドの区別
      $ftype, $cmd = $_.Split('=')
      # 実行ファイルのフルパス取得
      $exe = [Regex]::Matches($cmd, '("[^"]*")')[0].Value
      # ファイルタイプに紐づくコマンドの変更
      cmd /c "ftype ${ftype}=${exe}${options} `"%1`""
    }
  )

  # 関連付け変更対象が0件の場合はExcelがインストールされていないか別のアプリが関連付けされている
  if($chg_cnt -eq 0) {
    Write-Warning "Excelアプリに紐づく拡張子がありませんでした。Excelがインストールされていないか別のアプリケーションが関連付けされている可能性があります。"
  }
}
# 関数をそのままExportする場合
Export-ModuleMember -Function Set-ExcelDefaultOption

# Aliasも設定してExportする場合
# Set-Alias <alias> Set-ExcelDefaultOption
# Export-ModuleMember -Function Set-ExcelDefaultOption -Alias <alias>
