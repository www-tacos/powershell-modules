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
    try {
      Import-Module $_.FullName -Force
      Write-Host "Imported: $($_.BaseName)"
    } catch {
      Write-Host "Not Imported: $($_.BaseName)"
    }
  }
}
```


## 各スクリプトの簡単な説明

- Get-ComObjectList.psm1
  - `New-Object`コマンドの`ComObject`パラメータで指定可能なオブジェクト一覧を取得する

- Get-FontFamily.psm1
  - フォントファミリ一覧を取得する

- Get-ItemList.psm1
  - Bashのlsみたいなやつ

- Get-PathFromDialog.psm1
  - ファイルやディレクトリを選択するダイアログを表示してパスを取得する

- Get-PropertyList.psm1
  - オブジェクトのプロパティ一覧を取得する

- Get-Sequence.psm1
  - Bashのseqみたいなやつ

- Get-TextFromDialog.psm1
  - テキストを入力するダイアログを表示してテキストを取得する

- Invoke-Excel.psm1
  - エクセルを起動する

- Invoke-Scrcpy.psm1
  - Scrcpyを起動する

- Remove-BOM.psm1
  - UTF8BOMからBOMを削除する

- Remove-Indent.psm1
  - インデントレベルを下げる

- Restart-IME.psm1
  - IMEを強制終了するためのコンソールを表示する

- Set-DebugPreference.psm1
  - デバッグモードを設定する

- Set-ExcelDefaultOption.psm1
  - エクセルのデフォルトの起動オプションを変更する

- Show-MsgBox.psm1
  - メッセージボックスを表示する

- Show-Toast.psm1
  - トースト通知を表示する

