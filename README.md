# PowerShell Scripts

- PowerShell Script 詰め合わせ
- ヘルプの書き方等は[この記事](https://qiita.com/www-tacos/items/200e88dec661400c2bb9)にまとめている


## 構成

- `Modules/`
  - オリジナルコマンドのモジュール詰め合わせ

- `TEMPLATE.psm1`
  - モジュールファイルのテンプレート

- `.vscode/ps1.code-snippets`
  - VSCode用のモジュールテンプレートのスニペット
  - `module` から変換可能


## 読み込み方法の例

### デフォルトのモジュールパスに配置する方法
- `$env:PSModulePath`に設定されているディレクトリにモジュールを配置すれば自動で読み込まれる


### プロファイルで明示的に読み込む方法
- `$PROFILE`に設定されている設定ファイルに読み込みスクリプトを追記する
  - Windows Powershellの場合 : `${env:HOMEPATH}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
  - Powershell Coreの場合 : `${env:HOMEPATH}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

```powershell:一括読み込み例
$MyModules = "${env:HOMEPATH}\git\powershell-scripts\Modules\"
if(Test-Path $MyModules -PathType Container) {
  Get-ChildItem $MyModules | Where-Object {
    # 読み込みたくないモジュールの除外
    return $_.Extension -eq '.psm1' -and $_.BaseName -notin @(
      'Invoke-Scrcpy'
    )
  } | ForEach-Object {
    Import-Module $_.FullName -Force
    Write-Host "Imported : $($_.FullName)"
  }
}
```
