Push-Location $psScriptRoot
. ./Utils.ps1
. ./VcsUtils.ps1
Pop-Location

Export-ModuleMember -Function @(
  'Write-VcsStatus',
  'Get-VcsStatus',
  'VcsTabExpansion',
  'Coalesce-Args',
  'Test-LocalOrParentPath'
) -Alias @(
  '??'
) -Variable @(
  'EnabledVcs',
  'VcsStatus'
)
