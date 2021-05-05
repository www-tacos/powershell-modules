function Restart-IME {
  <#
  .SYNOPSIS
  IME ���ċN������
  
  .DESCRIPTION
  IME�̃v���Z�XID��\�����āA����ID���w�肵�ăv���Z�X���I�����AIME���ċN������
  
  .EXAMPLE
  PS> Restart-IME
  �e��v���Z�X�����s����
  
  .LINK
  �Q�l�����N
  https://qiita.com/_masa_u/items/b2e9c07f51a909c6e9b8
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Restart-IME; return }

  tasklist /fi "imagename eq ctfmon.exe"
  Write-Host ''
  $IME_PID = Read-Host 'Enter PID of ctfmon.exe'
  $command = "taskkill /pid ${IME_PID}; ctfmon.exe; Write-Host 'Finished. This process will finish after 10 seconds'; Start-Sleep 10"
  Start-Process -FilePath powershell -ArgumentList $command -Verb runas
}
Export-ModuleMember -Function Restart-IME
