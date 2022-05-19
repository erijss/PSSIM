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

        Write-Host "========================================================"
        Write-Host ""
        Write-Host "Sorry, the action '$ActionName' is not"
        Write-Host "implemented yet."
        Write-Host ""
        Write-Host "========================================================"
    }
}
