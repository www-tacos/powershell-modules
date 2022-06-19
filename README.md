# PowerShell Scripts

- PowerShell Script 詰め合わせ
- ヘルプの書き方等は[この記事](https://qiita.com/www-tacos/items/200e88dec661400c2bb9)にまとめている


## 構成

- `common/`
  - PowerShellのバージョンによらず（ほぼ）正常に実行可能なスクリプトモジュール

- `5.1/`
  - Windows PowerShell 5.1まででしか実行できないスクリプトモジュール
    - .NETのモジュールを使っているものなど？

- `6/`
  - PowerShell Core 6.0以降でしか実行できないスクリプトモジュール

- `common_6/`
  - common配下のスクリプトモジュールをPowerShell Core 6.0以降用に文字コードをUTF8に変換して一時的に配置するためのディレクトリ
  - gitの管理対象に入れない

- `dev/`
  - 開発途中のスクリプトモジュール

- `.vscode/ps1.code-snippets`
  - VSCode用のモジュールテンプレートのスニペット
  - `module` で呼び出す

- `.vscode/settings.json`
  - スクリプトモジュールの文字コードと改行コードのデフォルトを指定する設定
  - ベースはShiftJIS+CRLFとして、6.0以降側で読み込むときに変換してもらう
    - 5.1側はBOMなしUTF8での読み込みが難しい（できない？）ため

- `import_5_1.ps1`
  - 5.1までのモジュールを読み込むためのスクリプト

- `import_6.ps1`
  - 6以上のモジュールを読み込むためのスクリプト


## 読み込み方法

- `$PROFILE`に設定されているプロファイルに読み込みスクリプトを追記する
  - Windows Powershellの場合
    - `${env:HOMEPATH}\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1`
  - Powershell Coreの場合
    - `${env:HOMEPATH}\Documents\PowerShell\Microsoft.PowerShell_profile.ps1`

```powershell
# モジュールの読み込み（パスは適宜cloneした場所とPowerShellのバージョンにあわせる）
# 5.1までの場合
. "${env:HOMEPATH}\git\powershell-scripts\import_5_1.ps1"

# 6以上の場合
. "${env:HOMEPATH}\git\powershell-scripts\import_6.ps1"
```



