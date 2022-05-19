function Set-PSSIMParameters {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    param (
        # Specifies a path to one or more locations. Wildcards are permitted.
        [Parameter(
            Mandatory = $true,
            HelpMessage = "Path the PSSIM Parameters File."
        )]
        [ValidateScript( {
                Test-Path -Path $_ -PathType Leaf
            } )]
        [string]
        $Path = ".\PSSIM-Parameters.json",

        # Switch to not show the set parameters
        [Parameter(
            HelpMessage = "Switch to not show the set parameters"
        )]
        [switch]
        $DoNotShowResult

    )
    process {
        PSSIM.Context.SetContext -File $Path

        if ( $DoNotShowResult ) {
            # Do not write the parameters to the output
        }
        else {
            Get-PSSIMParameters
        }
    }
}
