param(
    [ValidateSet("deploy")]
    [string]$Command,
    [Parameter(Mandatory)]
    [string]$ConfigDataFolderPath,
    [Parameter(Mandatory)]
    [string]$serviceName
)
function Test-EnvironmentVariables {
    $requiredVariables = @(
        "SEARCH_SERVICE_NAME", "SEARCH_SERVICE_MI_NAME","TEAM_MI_NAME","SERVICE_MI_NAME",        
        "SSV_SHARED_SUBSCRIPTION_ID","AZURE_TENANT_ID","TEAM_MI_CLIENT_ID", 
        "KEY_VAULT_NAME", "SP_CLIENT_ID_KV", "SP_CLIENT_SECRET_KV"
    )
    $missingVariables = $requiredVariables | Where-Object { 
        [string]::IsNullOrWhiteSpace([Environment]::GetEnvironmentVariable($_)) 
    }
    if ($null -ne $missingVariables -and $missingVariables.Count -gt 0) {
        Write-LogInfo "Missing required variables: $($missingVariables -join ', ')"
    }
}

Set-StrictMode -Version 3.0

Import-Module -Name Logger -Force
Import-Module -Name Deploy -Force

try {
    
    Write-LogInfo "Validating environment variables..."
    Test-EnvironmentVariables

    Write-LogInfo "Starting pre-Deploy..."
    # Invoke-PreDeploy -AdGroups: @{ DbReader =  $env:PG_READER_AD_GROUP ; DbWriter =  $env:PG_WRITER_AD_GROUP } `
    #                     -KeyVaultName $env:KEY_VAULT_NAME `
    #                     -SPNSecretNames @{ clientIdName = $env:SP_CLIENT_ID_KV; clientSecretName = $env:SP_CLIENT_SECRET_KV } `
    #                     -ServiceMIName $env:SERVICE_MI_NAME -TeamMIName $env:TEAM_MI_NAME `
    #                     -SubscriptionId $env:SSV_SHARED_SUBSCRIPTION_ID -TenantId $env:AZURE_TENANT_ID 

    Write-LogInfo "Starting Deploy for $serviceName"
    Invoke-Deploy -searchServicesName $env:SEARCH_SERVICE_NAME -ConfigDataFolderPath $ConfigDataFolderPath `
                     -apikey $env:SEARCH_SERVICE_MI_NAME
    
    # Write-LogInfo "Starting post-Deploy..."        
    # Invoke-PostDeploy -ServiceMIName $env:SERVICE_MI_NAME -AdGroup $env:PG_READER_AD_GROUP `
    #                      -ClientId $env:TEAM_MI_CLIENT_ID
}
catch {
   Write-LogError -Message "Deploy failed: $_"
}