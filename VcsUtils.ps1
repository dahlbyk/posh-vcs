Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

if(-not $EnabledVcs) {
    $EnabledVcs = Get-ChildItem | Where-Object { $_.PSIsContainer } | ForEach-Object { $_.Name }
}

$Vcs = $EnabledVcs |
    ForEach-Object {
       Import-Module $(Get-ChildItem $_ *.psm1).FullName -Prefix $_ -AsCustomObject -Force
    }

$AdditionalExports = $Vcs | ?{ $_.AdditionalExports } | %{ $_.AdditionalExports() } | ?{ $_ }

function Write-VcsStatus {
    foreach($v in $Vcs) {
        if($s = $v.'Get-VcsStatus'()) {
			$Global:VcsStatus = $s
            $v.'Write-VcsStatus'($s)
            break
        }
    }
}

function VcsTabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]

    foreach($v in $Vcs) {
        $p = $v.VcsTabPattern()
        if($lastBlock -match $p) {
			return $v.VcsTabExpansion($lastBlock, $Global:VcsStatus)
        }
    }

    return $null
}

Pop-Location
