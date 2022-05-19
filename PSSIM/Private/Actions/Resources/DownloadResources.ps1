function PSSIM.Action.DownloadResources {
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
    PSSIM.UserInteraction.WriteNotImplmented -ActionName "DownloadResources"
    # $packages = $PSSIM.Context.Resources.Packages

    # foreach ($package in $packages.GetEnumerator()) {
    #     $name = $package.Value
    #     $target = [System.IO.Path]::Combine($PSSIM.Context.Resources.Folder, $name)

    #     if ( Test-Path -Path $path -PathType Leaf ) {
    #         # Do nothing, file exists
    #     }
    #     else {
    #         $uri = "https://sitecoreinstallresources.blob.core.windows.net/1020/{0}?sp=r&st=2021-12-31T23:00:00Z&se=2024-12-31T23:00:00Z&spr=https&sv=2020-08-04&sr=c&sig=NcbmZMCkW0HH0%2BOn31tRDtcRtQTl3tTS5PrzR3Nm0dM%3D" -f $name
    #         Invoke-WebRequest -Uri $uri -OutFile $target
    #     }

    # }
}
