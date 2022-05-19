function PSSIM.UserInteraction.WriteError {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    [CmdletBinding()]
    param (
        $RaisedError
    )

    process {
        Pop-Location
        Write-Error $RaisedError
        throw
    }
}
