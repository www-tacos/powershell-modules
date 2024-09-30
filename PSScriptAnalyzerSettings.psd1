# 参考: https://qiita.com/nimzo6689/items/1c55c6782027a78a51e5
@{
  # ルールの部分カスタム
  Rules        = @{
    # 以下のエイリアスについては使用可能とする。
    PSAvoidUsingCmdletAliases = @{
      Whitelist = @(
        '%'
        '?'
        'compare'
        'diff'
        'foreach'
        'group'
        'measure'
        'select'
        'sort'
        'tee'
        'where'
      )
    }
    # スクリプト内のコマンドレットがPowerShell Coreと互換性があるか確認する。
    PSUseCompatibleCmdlets    = @{ Compatibility = @("core-6.0.0-alpha-linux") }
  }

  # 除外ルール
  ExcludeRules = @(
    # Write-Hostによる色付きのメッセージ出力を許容
    'PSAvoidUsingWriteHost'
    # nullとの比較は右辺に置くことを許容
    'PSPossibleIncorrectComparisonWithNull'
    # 未使用変数を許容
    'PSUseDeclaredVarsMoreThanAssignments'
    # 空のcatchを許容
    'PSAvoidUsingEmptyCatchBlock'
  )
}
