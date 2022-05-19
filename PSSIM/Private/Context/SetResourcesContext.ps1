function PSSIM.Context.SetResourcesContext {
    <#
    .SYNOPSIS
        Sets all the Folders variables
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    process {
        $config =  $PSSIM.Configuration

        $resources = @{}
        $resources.DownloadLocation =  $config | PSSIM.Functions.FindJsonPath -JsonPath "resources.downloadlocation" | PSSIM.Helpers.GetValue
        $resources.Folder =  $config | PSSIM.Functions.FindJsonPath -JsonPath "resources.folder" | PSSIM.Helpers.GetValue

        if( (Test-Path -Path $resources.Folder) -eq $false )
        {
            throw $("Folder '$resources.Folder.Value' does not exit. Be sure that you add the correct path to the resources folder.")
        }

        $packagesJsonPath = "packages." + $PSSIM.Context.Sitecore.Version
        $packagesList = $config | PSSIM.Functions.FindJsonPath -JsonPath $packagesJsonPath | PSSIM.Functions.ConvertToHashtable
        $packages = @{}

        foreach ($package in $packagesList.GetEnumerator())
        {
            $packageInfo = @{}
            $packageInfo.Name = $package.Value.Name
            $packageInfo.Path = [System.IO.Path]::Combine($resources.Folder, $PSSIM.Context.Sitecore.Version, $packageInfo.Name)
            $packageInfo.Url = ""

            $packages.Add($package.Key, $packageInfo)

        }

        $resources.Packages = $packages

        $PSSIM.Context.Resources = $resources
    }
}
