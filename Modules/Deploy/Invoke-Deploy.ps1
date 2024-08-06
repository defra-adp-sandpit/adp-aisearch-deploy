function Invoke-Deploy {
    param(
        [Parameter(Mandatory)]
        [string]$searchServicesName,
        [string]$apikey,    
        [string]$ConfigDataFolderPath
    )

    Function Set-AzureSearchObject {
        [CmdletBinding()]
        param(
            [Parameter(Mandatory = $true)][string]$ApiKey,
            [Parameter(Mandatory = $true)][string]$SearchServicesName,
            [Parameter(Mandatory = $true)][string]$Type,
            [Parameter(Mandatory = $true)][string]$Name,
            [Parameter(Mandatory = $true)][string]$Source
        )
        Write-Host "Creating/ Updating Datasource $Name for Search Service $SearchServicesName"
        $body = Get-Content -Raw -Path $Source | ConvertFrom-Json
    
        $body.name = $Name
 
        $bodyText = ConvertTo-Json -InputObject $body -Compress -Depth 20

        $headers = @{
            "Authorization" = "Bearer $($ApiKey)"
            "Content-Type"  = "application/json"
        }
        $ApiVersion = "2024-05-01-Preview"
        $url = "https://$($SearchServicesName).search.windows.net/$($Type)/$($Name)/?api-version=$($ApiVersion)"
 
        Invoke-RestMethod -Uri $url -ContentType "application/json" -Headers $headers -Method Put -Body $BodyText -UseBasicParsing
    }

    try {
        if ($null -eq $ConfigDataFolderPath) {
            throw "One of the parameter 'ConfigDataFolderPath' is required."
        }

        $dirNames = @('datasources', 'indexes', 'skillsets', 'indexers')
        ForEach ($dir in $dirNames) {    
            $Files = Get-ChildItem -Path "$($ConfigDataFolderPath)/$dir"
            ForEach ($File in $Files) {            
                #Set-AzureSearchObject -Type $dir -Name $($File.Basename) -Source $($File.FullName) -SearchServicesName $searchServicesName -ApiKey $apikey            
                Write-LogInfo "dir: $dir, File: $($File.Basename) SearchServicesName: $searchServicesName, ApiKey: $apikey"
            }
        }        
        $exitCode = 0
    }
    catch {
        $exitCode = -2
        Write-LogError $_.Exception.ToString()
    }
    finally {
        if ($exitCode -eq 0) {
            Write-LogInfo "Search Service deployment completed successfully"
        }
        else {
            Write-LogError "Search Service deployment failed"
        }
    }

}