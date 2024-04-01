# PowerShell Scripts

- PowerShell Script 詰め合わせ

- ヘルプの書き方等は[この記事](https://qiita.com/www-tacos/items/200e88dec661400c2bb9)にまとめている

## 構成

- `common/`
  - PowerShellのバージョンによらず（ほぼ）正常に実行可能なスクリプトモジュール

- `desktop/`
  - Windows PowerShell 5.1まででしか実行できないスクリプトモジュール
    - `.NET Framework` に依存するスクリプト

- `core/`
  - PowerShell 6.0以降でしか実行できないスクリプトモジュール
    - `.NET Core` に依存するスクリプト

- `dev/`
  - 開発途中のスクリプトモジュール

- `.vscode/ps1.code-snippets`
  - VSCode用のモジュールテンプレートのスニペット
  - `module` で呼び出す

- `import_~~.ps1`
  - common/desktop/coreそれぞれのモジュールを一括で読み込むスクリプト

## 使用方法

- プロファイルに読み込みスクリプトを追記する
  - Windows Powershellの場合
    - `${env:HOMEPATH}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
  - Powershell Coreの場合
    - `${env:HOMEPATH}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

```powershell
# モジュールの読み込み（パスは適宜cloneした場所とPowerShellのバージョンにあわせる）
$repository = "${env:HOMEPATH}\git\powershell-scripts\"

# 共通モジュール
. "${repository}\import_common.ps1"

# Desktop用モジュール
if ($PSEdition -eq "Desktop") {
  . "${repository}\import_desktop.ps1"
}
# Core用モジュール
if ($PSEdition -eq "Core") {
  . "${repository}\import_core.ps1"
}
```
