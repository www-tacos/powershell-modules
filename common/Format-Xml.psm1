function Format-Xml {
  <#
  .SYNOPSIS
    XMLをフォーマットする

  .DESCRIPTION
    XMLオブジェクトを受け取り、フォーマットした文字列を返す

  .PARAMETER Help|h
    ヘルプを表示する

  .PARAMETER XmlObject
    XMLオブジェクト

  .PARAMETER IndentSize
    インデントのスペース数（デフォルトは4）

  .PARAMETER CommonParameters
    サポートしていません

  .INPUTS
    XMLオブジェクト

  .OUTPUTS
    文字列

  .EXAMPLE
    PS> Format-Xml -InputObject ([xml](Get-Content ./sample.xml)) -IndentSize 2
      sample.xmlをインデントをスペース2つでフォーマットした文字列を返す

  .EXAMPLE
    PS> Format-Xml -Help
      ヘルプを表示する
  #>
  Param(
    [xml] $XmlObject,
    [int] $IndentSize = 4,
    [Alias('h')][switch] $Help
  )
  if ($Help) { Get-Help Format-Xml; return }

  #------------------------------
  # Main処理
  #------------------------------
  if ($XmlObject -isnot [xml]) {
    throw [System.ArgumentException]::new("XmlObject is not XML")
  }
  else {
    $sb = [System.Text.StringBuilder]::new()
    $sw = [System.IO.StringWriter]::new($sb)
    $writer = [System.Xml.XmlTextWriter]::new($sw)
    $writer.Formatting = [System.Xml.Formatting]::Indented
    $writer.IndentChar = ' '
    $writer.Indentation = $IndentSize
    $XmlObject.Save($writer)
    $writer.Close()
    $sw.Dispose()
    return $sb.ToString()
  }
}
# コマンドレットをExport
Export-ModuleMember -Function Format-Xml
