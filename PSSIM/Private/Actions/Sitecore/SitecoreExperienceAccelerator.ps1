function PSSIM.Action.SitecoreExperienceAccelerator {
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
            Write-Warning "Sitecore Expereience Accelerator installation for versions below 10.2.0 is not implemented yet"
            return
        }

        $parameters = @{}

        switch ( $PSSIM.Context.Sitecore.Topology ) {
            "XM0" {
                $parameters.Add("Path", "SXA-SingleDeveloper-XM0.json")
                $parameters.Add("SiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("SXAPackage", $PSSIM.Context.Resources.Packages.SXA_XM_CM.Path)
                $parameters.Add("SPEPackage", $PSSIM.Context.Resources.Packages.POWERSHELLEXTENSIONS.Path)
                # $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                # $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
            "XM1" {
                $parameters.Add("Path", "SXA-SingleDeveloper-XM1.json")
                $parameters.Add("SitecoreContentManagementSiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SitecoreContentDeliverySiteName", $PSSIM.Context.Sitecore.Roles.CD.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("SXACMPackage", $PSSIM.Context.Resources.Packages.SXA_XM_CM.Path)
                $parameters.Add("SXACDPackage", $PSSIM.Context.Resources.Packages.SXA_XM_CD.Path)
                $parameters.Add("SPEPackage", $PSSIM.Context.Resources.Packages.POWERSHELLEXTENSIONS.Path)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
            "XP0" {
                $parameters.Add("Path", "SXA-SingleDeveloper-XP0.json")
                $parameters.Add("SiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("SXAPackage", $PSSIM.Context.Resources.Packages.SXA_XP_CM.Path)
                $parameters.Add("SPEPackage", $PSSIM.Context.Resources.Packages.POWERSHELLEXTENSIONS.Path)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
            "XP1" {
                $parameters.Add("Path", "SXA-SingleDeveloper-XP1.json")
                $parameters.Add("SitecoreContentManagementSiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SitecoreContentDeliverySiteName", $PSSIM.Context.Sitecore.Roles.CD.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("SXACMPackage", $PSSIM.Context.Resources.Packages.SXA_XM_CM.Path)
                $parameters.Add("SXACDPackage", $PSSIM.Context.Resources.Packages.SXA_XM_CD.Path)
                $parameters.Add("SPEPackage", $PSSIM.Context.Resources.Packages.POWERSHELLEXTENSIONS.Path)
                # $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                # $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
        }

        $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + "SXA" + "_" + $PSSIM.Context.Sitecore.Topology + "_" + $PSSIM.Context.Sitecore.Version

        if ( $PSSIM.Context.Settings.Uninstall ) {
            Write-Warning "Sitecore Experience Accelerator cannot be uninstalled"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "SXA"
        }
    }
}
