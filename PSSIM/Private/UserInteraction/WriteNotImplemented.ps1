function PSSIM.UserInteraction.WriteNotImplemented {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .HostS
    .NOTES
    #>
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]
        $ActionName
    )

    process {
        PSSIM.UserInteraction.ClearHost -Cls $true
        Write-Warning "Sorry, the action '$ActionName' is not implemented yet"
    }
}
