function Invoke-PSSIF {
    <#
    .SYNOPSIS
        Invoke the Json menu definition to run a menu in the console or as a system tray menu
    .DESCRIPTION
        Invoke-Menu creates a menu based on structured Json format. The Json contains definitions for menu optinos
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Input (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    [CmdletBinding(DefaultParameterSetName = 'Object')]
    param (
    )
    process {
        PSSIF.UserInteraction.ClearHost -Cls $true
        PSSIF.UserInteraction.WriteLogo
    }
}
