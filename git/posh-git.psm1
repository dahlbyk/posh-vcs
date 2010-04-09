Push-Location $psScriptRoot
. ./GitUtils.ps1
. ./GitPrompt.ps1
. ./GitTabExpansion.ps1
Pop-Location

function AdditionalExports {
    'Enable-GitColors'
}

Export-ModuleMember -Function @(
  'Write-VcsStatus',
  'Get-VcsStatus',
  'VcsTabExpansion',
  'VcsTabPattern',

  'AdditionalExports',
  'Enable-Colors'
)
