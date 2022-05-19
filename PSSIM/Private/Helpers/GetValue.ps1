function PSSIM.Helpers.GetValue {
    <#
    .SYNOPSIS
        Gets the value of a installation parameters paramerer
    .DESCRIPTION
        Installation Parameters file can be an documented or a condensed variant
        in the documented variant, a parameter has this syntax:

        "parameter" : {
            "description": " ",
            "<other properties": " ",
            "value": "the value"
        }

        In the condensed variant the parameter is:

        "parameter": "the value"

        Goal of this module is to test whether it's the documentend or flattened form and return the real value
    .EXAMPLE
    .INPUTS
        $Parameter
    .OUTPUTS
        Parameter value
    .NOTES
    #>
    [CmdletBinding()]
    param (
        [Parameter(
            ValueFromPipeline
        )]
        [Object]
        $Parameter
    )
    process {
        if ($Parameter -is [Hashtable] ) {
            return $Parameter.value
        }
        elseif ($Parameter -is [String]) {
            return $Parameter
        }
        elseif ($Parameter -is [System.Management.Automation.PSCustomObject]) {
            return $Parameter.value
        }
        else {
            return $Parameter
        }
    }
}
