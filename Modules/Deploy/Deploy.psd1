@{
    ModuleVersion     = '1.0.0'
    GUID              = '2eedc4d3-385c-4f1d-b331-04d1382f8794'
    Author            = 'Defra ADP Team'
    CompanyName       = 'Defra'
    Copyright         = '(c) Defra. All rights reserved.'
    ScriptsToProcess = @(
        'Internal/Add-MIToADGroup.ps1'
        'Invoke-PreDeploy.ps1'
        'Invoke-Deploy.ps1'
        'Invoke-PostDeploy.ps1'
    )
    FunctionsToExport = @(
        'Invoke-PreDeploy'
        'Invoke-Deploy'
        'Invoke-PostDeploy'
    )

    RequiredModules   = @(
        './Modules/Logger/Logger.psd1'
        './Modules/Auth/Auth.psd1'
    )
    
    CmdletsToExport   = @()
    AliasesToExport   = @()
    PrivateData       = @{
        PSData = @{
        } 
    }    
    
}