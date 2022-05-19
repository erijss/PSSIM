function PSSIM.Context.SetContext {
    <#
    .SYNOPSIS
        Sets all the Solr variables
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $File
    )
    process {

        try {
            $PSSIM.Configuration = Get-Content -Path $File  -Force -Raw | ConvertFrom-Json
        }
        catch {
            PSSIM.UserInteraction.WriteError $_
        }

        $filepath = Get-ChildItem $File

        $fileDetails = @{}
        $fileDetails.Name = $filepath.Name
        $fileDetails.Folder = $filepath.Directory.FullName
        $PSSIM.Context.File = $fileDetails

        PSSIM.Context.SetSitecoreContext
        PSSIM.Context.SetResourcesContext
        PSSIM.Context.SetSolrContext
        PSSIM.Context.SetSqlServerContext
        PSSIM.Context.SetCertificatesContext
        PSSIM.Context.SetRedisContext
    }
}
