Push-Location $psScriptRoot
. ./Utils.ps1
. ./VcsUtils.ps1
Pop-Location

$functions = 

Export-ModuleMember -Function (
  @(
    'Write-VcsStatus',
    'Get-VcsStatus',
    'VcsTabExpansion',
    'Coalesce-Args',
    'Test-LocalOrParentPath'
  ) + $AdditionalExports
) -Alias @(
  '??'
) -Variable @(
  'EnabledVcs',
  'VcsStatus'
)
