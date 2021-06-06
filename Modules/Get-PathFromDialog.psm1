# $script:PT_F = 'File'
function Get-PathFromDialog {
  <#
  .SYNOPSIS
    システムダイアログを表示してパスを取得する
  
  .DESCRIPTION
    ダイアログを表示し、選択されたディレクトリまたはファイルのパスを返す
    キャンセルやエスケープでアイテムが選択されなかった場合、エラーを返す
  
  .PARAMETER Help|h
    ヘルプを表示する
  
  .PARAMETER PathType
    選択するパスのタイプ（ファイル/ディレクトリ）を選択する
  
  .PARAMETER CommonParameters
    サポートしていません
  
  .INPUTS
    なし
  
  .OUTPUTS
    ダイアログの表示、選択されたディレクトリまたはファイルのフルパス
  
  .EXAMPLE
    PS> Get-PathFromDialog -Help
      ヘルプを表示する
  
  .EXAMPLE
    PS> Get-PathFromDialog -PathType File
      ファイルを選択するダイアログを表示し、選択されたファイルのパスを得る
  
  .LINK
    参考: 引用元
    https://buralog.jp/powershell-folderbrowserdialog/

    参考: 前面固定
    https://stackoverflow.com/questions/36714807/how-to-set-a-window-to-be-topmost-in-powershell
  #>
  Param(
    [Alias('h')][switch] $Help,
    [ValidateSet('File', 'Directory')][string] $PathType
  )
  if($Help){ Get-Help Get-PathFromDialog; return }

  #------------------------------
  # Main処理
  #------------------------------
  Add-Type -AssemblyName System.Windows.Forms
  switch ($PathType) {
    'File' {
      $d = New-Object System.Windows.Forms.OpenFileDialog -Property @{ 
        InitialDirectory = $env:HOMEPATH
        Title = 'ファイルを選択してください'
        CheckFileExists = $true
        CheckPathExists = $true
        Multiselect = $false
        # Filter = 'テキスト (*.txt)|*.txt'
      }
      $property = 'FileName'
    }
    'Directory' {
      $d = New-Object System.Windows.Forms.FolderBrowserDialog -Property @{ 
        RootFolder = "MyComputer"
        Description = 'フォルダを選択してください'
      }
      $property = 'SelectedPath'
    }
    Default {
      throw "Error: 無効なPathType (${PathType})"
    }
  }

  # 最前面固定で中央に表示
  $res = $d.ShowDialog(
    (New-Object System.Windows.Forms.Form -Property @{
      TopMost = $true
      StartPosition = "CenterScreen"
    })
  )

  # パスまたはエラーを返す
  if($res -eq [System.Windows.Forms.DialogResult]::OK) {
    return $d.$property
  } else {
    throw "パスが選択されませんでした"
  }
}
# 関数をそのままExportする場合
Export-ModuleMember -Function Get-PathFromDialog

# Aliasも設定してExportする場合
# Set-Alias <alias> Get-PathFromDialog
# Export-ModuleMember -Function Get-PathFromDialog -Alias <alias>
