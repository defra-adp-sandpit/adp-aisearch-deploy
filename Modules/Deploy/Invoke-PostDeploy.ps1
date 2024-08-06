function Invoke-PostDeploy {
    param(
        [Parameter(Mandatory)]
        [string]$ServiceMIName,

        [Parameter(Mandatory)]
        [string]$AdGroup,

        [Parameter(Mandatory)]
        [string]$ClientId
    )
    
    Write-LogInfo "Granting Database scheams access to $ServiceMIName "

}