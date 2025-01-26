# PowerShell Modules

公開可能な PowerShell のスクリプトモジュールの詰め合わせ

ヘルプの書き方等は[この記事](https://qiita.com/www-tacos/items/200e88dec661400c2bb9)にまとめている

## 構成

| ファイル/フォルダ           | 説明                                                             |
| :-------------------------- | :--------------------------------------------------------------- |
| `common`                    | PowerShellのどのバージョンでも実行可能なスクリプトモジュール     |
| `Desktop`                   | Windows PowerShell 5.1まででしか実行できないスクリプトモジュール |
| `Core`                      | PowerShell 6.0以降でしか実行できないスクリプトモジュール         |
| `dev`                       | 開発途中のスクリプトモジュール                                   |
| `.vscode/ps1.code-snippets` | VSCode用のモジュールテンプレートのスニペット                     |
| `import.ps1`                | モジュールを一括で読み込むスクリプト                             |

## 使用方法

* プロファイルで読み込み用スクリプトを実行する

```powershell
# モジュールの読み込み（パスは適宜cloneした場所にあわせる）
$ImportModuleScriptPath = "{クローンしたディレクトリ}\import.ps1"
if (Test-Path $ImportModuleScriptPath) {
  . $ImportModuleScriptPath
}
```
