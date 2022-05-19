function PSSIM.Action.SitecorePrerequisites {
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

        $tempLocation = Join-Path -Path $PSSIM.Context.Resources.Folder -ChildPath "Prerequisites"

        if (!(Test-Path $tempLocation) )
        {
            $tempLocation = $(New-Item -Path $tempLocation -ItemType Directory).FullName
        }

        $parameters = @{}
        $parameters.Add("Path", "Prerequisites.json")
        $parameters.Add("TempLocation", $tempLocation)

        if ( $PSSIM.Context.Settings.Uninstall  ) {
            Write-Output "Prerequisites cannot be uninstalled"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition "Prerequisites" -SIFFolder "Prerequisites"
        }

    }
}
