function Install-FromPSSIMParameters {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    param (

        # Parameter help description
        [Parameter(
            Mandatory = $false,
            HelpMessage = "Action to be executed. Use Show-PSSIMActions to get an overview of all actions."
        )]
        [string]
        $Action,

        # Specifies if the module should be uninstalled
        [Parameter(
            HelpMessage = "Switch to Uninstall the module"
        )]
        [switch]
        $Uninstall,

        # Specifies if the specified module should installed in Update modus
        [Parameter(
            HelpMessage = "Switch to Update the module"
        )]
        [switch]
        $Update,

        # Specifies a path to one or more locations. Wildcards are permitted.
        [Parameter(
            Mandatory = $false,
            HelpMessage = "Path the PSSIM Installation Parameters File."
        )]
        [ValidateScript( {
                Test-Path -Path $_ -PathType Leaf
            } )]
        [string]
        $Path = ".\PSSIM-Parameters.json",

        # Parameter help description
        [Parameter(
            HelpMessage = "Switch to don't show the logo"
        )]
        [switch]
        $NoLogo

    )
    process {

        if ( $NoLogo ) { $PSSIM.Context.Settings.NoLogo = $true }
        PSSIM.UserInteraction.ClearHost -Cls $true
        PSSIM.UserInteraction.WriteLogo

        $PSSIM.Context.Settings.WorkingDirectory = $PWD
        $PSSIM.Context.Settings.Uninstall = [bool]$Uninstall
        $PSSIM.Context.Settings.Update = [bool]$Update

        if ( $Path -ne "") {
            PSSIM.Context.SetContext -File $Path
        }

        if ( $Action -eq "") {
            $actions = Get-ChildItem -Path ([System.IO.Path]::Combine($PSSIM.Info.ModulePath, "Private", "Actions")) -Include *.ps1 -File -Recurse -ErrorAction Stop

            Write-Output "================== Actions ======================="
            $actions | ForEach-Object {
                [System.IO.Path]::GetFileNameWithoutExtension($_)
            }
            Write-Output ""
        }
        else {
            $actionFunction = "PSSIM.Action." + $Action
            & $actionFunction
        }
    }
}
