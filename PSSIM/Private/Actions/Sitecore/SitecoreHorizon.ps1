function PSSIM.Action.SitecoreHorizon {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    param (
    )
    process {

        if ( $PSSIM.context.Sitecore.Version -ne "1020" ) {
            Write-Warning "Sitecore Horizon installation for versions below 10.2.0 is not implemented yet"
            return
        }

        # Horizon Host
        $horizonparameters = @{
            Path                         = "horizon-install-package.json"
            InstanceName                 = $PSSIM.Context.Sitecore.Roles.Horizon.Hostname
            PhysicalPath                 = $PSSIM.Context.Sitecore.Roles.Horizon.Folder
            PackagePath                  = $PSSIM.Context.Resources.Packages.HORIZON_HOST.Path
            AppUrl                       = $PSSIM.Context.Sitecore.Roles.Horizon.Url
            ContentManagementUrl         = $PSSIM.Context.Sitecore.Roles.CM.Url
            ContentManagementInternalUrl = $PSSIM.Context.Sitecore.Roles.CM.Url
            LicensePath                  = $PSSIM.Context.Sitecore.LicenseFile
            IdentityServerUrl            = $PSSIM.Context.Sitecore.Roles.Identity.Url
            EnableContentHub             = $PSSIM.Context.Sitecore.Roles.Horizon.EnableContentHub
            EnableSXA                    = $PSSIM.Context.Sitecore.Roles.Horizon.EnableSXA
        }

        $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + "SitecoreHorizonHost" + "_" + $PSSIM.Context.Sitecore.Topology + "_" + $PSSIM.Context.Sitecore.Version

        if ( $PSSIM.Context.Settings.Uninstall ) {
            PSSIM.Sitecore.UnInstallConfiguration -Parameters $horizonparameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Horizon"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $horizonparameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Horizon"
        }


        # Identity
        $identityparameters = @{
            Path                       = "horizon-update-identity-server.json"
            HorizonApplicationUrl      = $PSSIM.Context.Sitecore.Roles.Horizon.Url
            IdentityServerPoolName     = $PSSIM.Context.Sitecore.Roles.Identity.Hostname
            IdentityServerPhysicalPath = $PSSIM.Context.Sitecore.Roles.Identity.Folder
        }

        $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + "SitecoreHorizonIdentity" + "_" + $PSSIM.Context.Sitecore.Topology + "_" + $PSSIM.Context.Sitecore.Version

        if ( $PSSIM.Context.Settings.Uninstall ) {
            Write-Warning "The changes to Identity Server for Horizon Host cannot be uninstalled"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $identityparameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Horizon"
        }

        # Configure Content Management Instance
        $contentmanagementparameters = @{
            Path                            = "horizon-update-sitecore-instance.json"
            CMSiteName                      = $PSSIM.Context.Sitecore.Roles.CM.Hostname
            CMSiteUrl                       = $PSSIM.Context.Sitecore.Roles.CM.Url
            CMAdminPassword                 = $PSSIM.Context.Sitecore.Roles.CM.AdminPassword
            CMSitePhysicalPath              = $PSSIM.Context.Sitecore.Roles.CM.Folder
            featureIntegrationPackageXPPath = $PSSIM.Context.Resources.Packages.HORIZON_XP.Path
            featureIntegrationPackageXMPath = $PSSIM.Context.Resources.Packages.HORIZON_XM.Path
            SolrCorePrefix                  = $PSSIM.Context.Sitecore.Prefix
            HorizonAppUrl                   = $PSSIM.Context.Sitecore.Roles.Horizon.Url
        }

        if ( ( $PSSIM.Context.Sitecore.Topology -eq "XMO" ) -or ( $PSSIM.Context.Sitecore.Topology -eq "XM1" ) ) {
            $contentmanagementparameters.Add("Topology","XM")
        }
        else {
            $contentmanagementparameters.Add("Topology","XP")
        }

        $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + "SitecoreHorizonContentManagment" + "_" + $PSSIM.Context.Sitecore.Topology + "_" + $PSSIM.Context.Sitecore.Version

        if ( $PSSIM.Context.Settings.Uninstall ) {
            Write-Warning "The changes to the Content Management instance for Horizon Host cannot be uninstalled"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $contentmanagementparameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Horizon"
        }
    }
}
