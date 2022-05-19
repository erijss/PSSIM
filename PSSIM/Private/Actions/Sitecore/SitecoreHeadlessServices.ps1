function PSSIM.Action.SitecoreHeadlessServices {
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
            Write-Warning "Sitecore Headless Services installation for versions below 10.2.0 is not implemented yet"
            return
        }

        $parameters = @{}

        switch ( $PSSIM.Context.Sitecore.Topology ) {
            "XM0" {
                $parameters.Add("Path", "SHS-SingleDeveloper-XM0.json")
                $parameters.Add("Package", $PSSIM.Context.Resources.Packages.HEADLESSSERVICES_XM_CM.Path)
                $parameters.Add("SiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
            "XM1" {
                $parameters.Add("Path", "SHS-SingleDeveloper-XM1.json")
                $parameters.Add("SHSCMPackage", $PSSIM.Context.Resources.Packages.HEADLESSSERVICES_XM_CM.Path)
                $parameters.Add("CMSiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("SHSCDPackage", $PSSIM.Context.Resources.Packages.HEADLESSSERVICES_XM_CD.Path)
                $parameters.Add("CDSiteName", $PSSIM.Context.Sitecore.Roles.CD.Hostname)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
            "XP0" {
                $parameters.Add("Path", "SHS-SingleDeveloper-XP0.json")
                $parameters.Add("Package", $PSSIM.Context.Resources.Packages.HEADLESSSERVICES_XP_CM.Path)
                $parameters.Add("SiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
            "XP1" {
                $parameters.Add("Path", "SHS-SingleDeveloper-XP1.json")
                $parameters.Add("SHSCMPackage", $PSSIM.Context.Resources.Packages.HEADLESSSERVICES_XP_CM.Path)
                $parameters.Add("CMSiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("SHSCDPackage", $PSSIM.Context.Resources.Packages.HEADLESSSERVICES_XP_CD.Path)
                $parameters.Add("CDSiteName", $PSSIM.Context.Sitecore.Roles.CD.Hostname)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            }
        }

        $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + "SitecoreHeadlessServices" + "_" + $PSSIM.Context.Sitecore.Topology + "_" + $PSSIM.Context.Sitecore.Version

        if ( $PSSIM.Context.Settings.Uninstall ) {
            Write-Warning "Sitecore Headless Services (aka JavaScript Services) cannot be uninstalled"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "SHS"
        }
    }
}
