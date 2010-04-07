Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# To enable only certain VCS modules, enumerate them in $EnabledVcs
# $EnabledVcs = -split 'git hg'

# Load posh-vcs module from current directory
Import-Module .\posh-vcs -DisableNameChecking

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-vcs


function prompt {
    Write-Host($pwd) -nonewline

    Write-VcsStatus $GitStatus

    return "> "
}

if(-not (Test-Path Function:\DefaultTabExpansion)) {
    Rename-Item Function:\TabExpansion DefaultTabExpansion
}

# Set up tab expansion and include git expansion
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]
    
    $t = VcsTabExpansion $line $lastWord
    if($t) { $t } else { DefaultTabExpansion $line $lastWord }
}

# Enable Git Colors
$env:TERM = 'cygwin'
$env:LESS = 'FRSX'

Pop-Location
