function Invoke-Deploy {
    param(
        [Parameter(Mandatory)]
        [string]$PostgreHost,
        [Parameter(Mandatory)]
        [string]$PostgrePort,
        [Parameter(Mandatory)]
        [string]$DbName,
        [Parameter(Mandatory)]
        [string]$DbUserName,
        [Parameter(Mandatory)]
        [string]$ClientId,
        [Parameter(Mandatory)]
        [string]$ChangeLogFile,
        [Parameter(Mandatory)]
        [string]$DefaultSchemaName,
        [Parameter(Mandatory)]
        [string]$Command        
    )

    if (-not (Test-Path $ChangeLogFile)) {
        Write-LogError "Change log file $ChangeLogFile does not exist."
    }

    if ($LASTEXITCODE -ne 0) {
        Write-LogError "Database $DbName Deploy failed with error."
    }

    Write-LogInfo "Database $DbName migrated successfully."
}