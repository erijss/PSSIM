function Install-FromPSSIMParameters {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    [Alias('Install-Solr')]
    [Alias('Install-Sitecore')]
    [Alias('Install-Horizon')]
    [Alias('Install-SPE')]
    [Alias('Install-SHH')]
    [Alias('Install-SXA')]
    [Alias('Install-PS')]
    [Alias('Install-Connect')]
    [Alias('Install-Tenant')]
    [Alias('Install-CH')]
    [Alias('Install-DAM')]
    [Alias('Install-CMP')]
    [Alias('Install-D365')]
    [Alias('Install-SF')]
    [Alias('Install-PS')]
    [Alias('Uninstall-Solr')]
    [Alias('Uninstall-Sitecore')]
    [Alias('Uninstall-Horizon')]
    [Alias('Uninstall-SPE')]
    [Alias('Uninstall-SHH')]
    [Alias('Uninstall-SXA')]
    [Alias('Uninstall-PS')]
    [Alias('Uninstall-Connect')]
    [Alias('Uninstall-Tenant')]
    [Alias('Uninstall-CH')]
    [Alias('Uninstall-DAM')]
    [Alias('Uninstall-CMP')]
    [Alias('Uninstall-D365')]
    [Alias('Uninstall-SF')]
    [Alias('Uninstall-PS')]
    param (

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            HelpMessage = "Action to be executed. Use Show-PSSIMActions to get an overview of all actions."
        )]
        [string]
        $Action,

        # Specifies if the module should be uninstalled
        [Parameter(
            HelpMessage = "Switch to Uninstall the module"
        )]
        [switch]
        $Uninstall,

        # Specifies if the specified module should installed in Update modus
        [Parameter(
            HelpMessage = "Switch to Update the module"
        )]
        [switch]
        $Update,

        # Specifies a path to one or more locations. Wildcards are permitted.
        [Parameter(
            Mandatory = $false,
            HelpMessage = "Path the PSSIM Installation Parameters File."
        )]
        [ValidateScript( {
                Test-Path -Path $_ -PathType Leaf
            } )]
        [string]
        $Path = ".\PSSIM-Parameters.json",

        # Parameter help description
        [Parameter(
            HelpMessage = "Switch to don't show the logo"
        )]
        [switch]
        $NoLogo

    )
    process {

        if ( $NoLogo ) { $PSSIM.Context.Settings.NoLogo = $true }
        PSSIM.UserInteraction.ClearHost -Cls $true
        PSSIM.UserInteraction.WriteLogo


        switch ($MyInvocation.InvocationName) {

            "Install-Solr" { $Action = "SolrSearchEngine" }
            "Install-Sitecore" { $Action = "SitecorePlatform" }
            "Install-Horizon" { $Action = "SitecoreHorizon" }
            "Install-SPE" { $Action = "SitecorePowerShellExtensions" }
            "Install-SHH" { $Action = "SitecoreHeadlessServices" }
            "Install-SXA" { $Action = "SitecoreExperienceAccelerator" }
            "Install-PS" { $Action = "SitecorePublishingService" }
            "Install-Connect" { $Action = "SitecoreConnectFramework" }
            "Install-Tenant" { $Action = "SitecoreConnectTenant" }
            "Install-CH" { $Action = "SitecoreConnectContentHub" }
            "Install-DAM" { $Action = "SitecoreConnectContentHubDAM" }
            "Install-CMP" { $Action = "SitecoreConnectContentHubCMP" }
            "Install-D365" { $Action = "SitecoreConnectDynamics" }
            "Install-SF" { $Action = "SitecoreConnectSalesForce" }
            "Uninstall-Solr" { $Action = "SolrSearchEngine"; $Uninstall = $true }
            "Uninstall-Sitecore" { $Action = "SitecorePlatform"; $Uninstall = $true }
            "Uninstall-Horizon" { $Action = "SitecoreHorizon"; $Uninstall = $true }
            "Uninstall-SPE" { $Action = "SitecorePowerShellExtensions"; $Uninstall = $true }
            "Uninstall-SHH" { $Action = "SitecoreHeadlessServices"; $Uninstall = $true }
            "Uninstall-SXA" { $Action = "SitecoreExperienceAccelerator"; $Uninstall = $true }
            "Uninstall-PS" { $Action = "SitecorePublishingService"; $Uninstall = $true }
            "Uninstall-Connect" { $Action = "SitecoreConnectFramework"; $Uninstall = $true }
            "Uninstall-Tenant" { $Action = "SitecoreConnectTenant"; $Uninstall = $true }
            "Uninstall-CH" { $Action = "SitecoreContentHub"; $Uninstall = $true }
            "Uninstall-DAM" { $Action = "SitecoreConnectContentHubDAM"; $Uninstall = $true }
            "Uninstall-CMP" { $Action = "SitecoreConnectContentHubCMP"; $Uninstall = $true }
            "Uninstall-D365" { $Action = "SitecoreConnectDynamics"; $Uninstall = $true }
            "Uninstall-SF" { $Action = "SitecoreConnectSalesForce"; $Uninstall = $true }
            Default {}
        }


        $PSSIM.Context.Settings.WorkingDirectory = $PWD
        $PSSIM.Context.Settings.Uninstall = [bool]$Uninstall
        $PSSIM.Context.Settings.Update = [bool]$Update

        if ( $Path -ne "") {
            PSSIM.Context.SetContext -File $Path
        }

        if ( $Action -eq "") {
            $actions = Get-ChildItem -Path ([System.IO.Path]::Combine($PSSIM.Info.ModulePath, "Private", "Actions")) -Include *.ps1 -File -Recurse -ErrorAction Stop

            Write-Output "================== Actions ======================="
            $actions | ForEach-Object {
                [System.IO.Path]::GetFileNameWithoutExtension($_)
            }
            Write-Output ""
        }
        else {
            $actionFunction = "PSSIM.Action." + $Action
            & $actionFunction
        }
    }
}
