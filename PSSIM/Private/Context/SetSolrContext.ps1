function PSSIM.Context.SetSolrContext {
    <#
    .SYNOPSIS
        Sets all the Solr variables
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    process {
        $config =  $PSSIM.Configuration

        $solr = @{}
        $solr.Root = $config | PSSIM.Functions.FindJsonPath -JsonPath "solr.folder" | PSSIM.Helpers.GetValue

        if( (Test-Path -Path $solr.Root) -eq $false )
        {
            throw $("Folder '$solr.Root.Value' does not exit")
        }

        $solr.Version = $config | PSSIM.Functions.FindJsonPath -JsonPath "solr.version" | PSSIM.Helpers.GetValue
        $solr.Prefix = $config | PSSIM.Functions.FindJsonPath -JsonPath "solr.prefix" | PSSIM.Helpers.GetValue
        $solr.Name = $solr.Prefix + "Solr-" + $solr.Version
        $solr.Domain = "localhost"
        $portPrefix = $($config | PSSIM.Functions.FindJsonPath -JsonPath "solr.portprefix" | PSSIM.Helpers.GetValue).ToString()
        $solr.Port = $portPrefix + $solr.Version.Replace(".","").ToString()
        $solr.Url = "https://" + $solr.Domain + ":" + $Solr.Port + "/solr"
        $solr.Folder = Join-Path -Path $solr.Root -ChildPath $solr.Name
        $solr.Service = $solr.Name
        $solr.Cores = $config | PSSIM.Functions.FindJsonPath -JsonPath "solr.cores" | PSSIM.Helpers.GetValue

        $PSSIM.Context.Solr = $solr
    }
}
