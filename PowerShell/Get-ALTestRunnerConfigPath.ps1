function Get-ALTestRunnerConfigPath {
    $ConfigPath = Find-ALTestRunnerConfigInFolder (Get-Location)
    if ($null -eq $ConfigPath) {
        $ConfigPath = Find-ALTestRunnerConfigInFolder (Split-Path (Get-Location) -Parent)
    }

    if ($null -eq $ConfigPath) {
        $ConfigPath = Join-Path (Join-Path (Get-Location) '.altestrunner') '.config'
    }

    return $ConfigPath
}

function Find-ALTestRunnerConfigInFolder {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Folder
    )

    Get-ChildItem $Folder -Recurse -Filter '.altestrunner' | ForEach-Object {
        $ConfigPath = (Join-Path $_.FullName 'config.json')
        if (Test-Path $ConfigPath) {
            return $ConfigPath
        }
    }
}

Export-ModuleMember -Function Get-ALTestRunnerConfigPath