function Get-ComObjectList {
  <#
  .SYNOPSIS
  Com Object �ꗗ�̎擾
  
  .DESCRIPTION
  New-Object�R�}���h��-ComObject�Ɏw��\�ȃp�����[�^�ꗗ���擾����
  -ComObject�g�p��
    PS> $excel = New-Object -ComObject Excel.Application
  
  .EXAMPLE
  PS> Get-ComObjectList
  �R���\�[����Ɉꗗ��\��
  
  .EXAMPLE
  PS> Get-ComObjectList | Where-Object { $_ -like "*excel*" }
  excel �Ńt�B���^�����O�������ʂ̂ݕ\��
  
  .EXAMPLE
  PS> Get-ComObjectList | Out-File -FilePath ./com-objects.txt -Encoding default
  �t�@�C���o��
    
  .LINK
  �Q�l�����N
  https://www.powershellmagazine.com/2013/06/27/pstip-get-a-list-of-all-com-objects-available/
  #>
  Param(
    [Alias('h')][switch] $Help
  )
  if($Help){ Get-Help Get-ComObjectList; return }

  ##### WRITE CODE HERE #####
  return Get-ChildItem HKLM:\Software\Classes -ErrorAction SilentlyContinue | Where-Object {
    $_.PSChildName -match '^\w+\.\w+$' -and (Test-Path -Path "$($_.PSPath)\CLSID")
  } | Select-Object -ExpandProperty PSChildName
}
Export-ModuleMember -Function Get-ComObjectList
