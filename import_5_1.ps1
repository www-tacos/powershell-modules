<#==================================================
���W���[���ǂݍ��ݗp�X�N���v�g for ~5.1
==================================================#>
# 5.1�p���W���[����common���W���[���̓ǂݍ���
@("5.1", "common") | ForEach-Object {
  $ModuleDir = Join-Path $PSScriptRoot $_
  if(Test-Path $ModuleDir -PathType Container) {
    Write-Host "From: $(Split-Path $ModuleDir -Leaf)"
    Get-ChildItem $ModuleDir | ForEach-Object {
      try {
        Import-Module $_.FullName -Force
        Write-Host "Imported: $($_.BaseName)"
      } catch {
        Write-Host "Import Failed: $($_.BaseName)"
      }
    }
  }
}

