function PSSIM.Action.SolrSearchEngine {
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

        $tempLocation = Join-Path -Path $PSSIM.Context.Resources.Folder -ChildPath "Solr"

        if (!(Test-Path $tempLocation) )
        {
            $tempLocation = $(New-Item -Path $tempLocation -ItemType Directory).FullName
        }

        $parameters = @{}
        $parameters.Add("Path", "Solr-SingleDeveloper.json")
        $parameters.Add("SolrVersion", $PSSIM.Context.Solr.Version)
        $parameters.Add("SolrDomain", "localhost")
        $parameters.Add("SolrPort", $PSSIM.Context.Solr.Port)
        $parameters.Add("SolrServicePrefix", $PSSIM.Context.Solr.Prefix)
        $parameters.Add("SolrInstallRoot", $PSSIM.Context.Solr.Root)
        $parameters.Add("SolrSourceURL", "http://archive.apache.org/dist/lucene/solr")
        $parameters.Add("SolrCloud", $false)
        $parameters.Add("JavaDownloadURL", "https://github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u242-b08/OpenJDK8U-jre_x64_windows_hotspot_8u242b08.zip")
        $parameters.Add("ApacheCommonsDaemonURL", "http://archive.apache.org/dist/commons/daemon/binaries/windows/commons-daemon-1.1.0-bin-windows.zip")
        $parameters.Add("TempLocation", $tempLocation)
        $parameters.Add("ServiceLocation", "HKLM:SYSTEM\\CurrentControlSet\\Services")
        $parameters.Add("SolrServiceStartTimeout", 8000)

        if ( $PSSIM.Context.Settings.Uninstall  ) {
            PSSIM.Sitecore.UnInstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition "Solr" -SIFFolder "Solr"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition "Solr" -SIFFolder "Solr"
        }

    }
}
