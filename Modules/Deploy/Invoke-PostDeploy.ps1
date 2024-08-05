function Invoke-PostDeploy {
    param(
        [Parameter(Mandatory)]
        [string]$PostgresHost,

        [Parameter(Mandatory)]
        [string]$DbName,

        [Parameter(Mandatory)]
        [string]$DbUserName,

        [Parameter(Mandatory)]
        [string]$ServiceMIName,

        [Parameter(Mandatory)]
        [string]$AdGroupDbReader,

        [Parameter(Mandatory)]
        [string]$ClientId
    )
    
    Write-LogInfo "Granting Database scheams access to $ServiceMIName for $DbName on $PostgresHost"

}