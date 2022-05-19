function PSSIM.Action.SitecorePowerShellExtensions {
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
        $parameters = @{}

        $parameters.Add("Path", "spe.json")
        $parameters.Add("Package", $PSSIM.Context.Resources.Packages.POWERSHELLEXTENSIONS.Path)
        $parameters.Add("SqlDbPrefix", $PSSIM.Context.Sitecore.Prefix)
        $parameters.Add("SiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
        $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
        $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
        $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
        $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
        $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")

        $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + "SitecorePowerShellExtensions" + "_" + $PSSIM.Context.Sitecore.Topology + "_" + $PSSIM.Context.Sitecore.Version

        if ( $PSSIM.Context.Settings.Uninstall ) {
            Write-Warning "Sitecore PowerShell Extensions cannot be uninstalled"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "spe"
        }
    }
}
