function PSSIM.Action.AddCustomSolrCores {
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
        $PSSIM.Context.Solr.Cores | ForEach-Object {
            $coreName = $_
            $parameters = @{}
            $parameters.Add("Path", "Solr-ManageCore.json")
            $parameters.Add("CoreName", $coreName)
            $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
            $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
            $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
            $parameters.Add("SolrBaseConfig", "_default")
            $parameters.Add("SolrCorePrefix", $PSSIM.Context.Sitecore.Prefix)
            $parameters.Add("Update", $PSSIM.Context.Settings.Update)

            $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + $coreName

            if ( $PSSIM.Context.Settings.Uninstall  ) {
                PSSIM.Sitecore.UnInstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Solr"
            }
            else {
                PSSIM.Sitecore.InstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Solr"
            }

            Write-Warning "Don't forget to populate the managed schema and rebuild the indexes for the new cores"
        }
    }
}
