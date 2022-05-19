function PSSIM.Functions.FindJsonPath {
    <#
    .SYNOPSIS
        Gets the value of a json property by path
    .DESCRIPTION
        From the root of the JSON a syntax like

        property1.property2.property3 can be uses to find property3 in:

        {
            property1 : {
                property2: {
                    property3 = ""
                }
            }
        }
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    [CmdletBinding()]
    param (
        [Parameter(
            ValueFromPipeline
        )]
        [Object]
        $JsonObject,

        [Parameter()]
        [String]
        $JsonPath,

        [Parameter()]
        [Switch]
        $MustExist
    )
    process {
        try {
            if ($JsonPath.Contains(".")) {
                $jsonPathArray = $JsonPath.Split(".")
                $current = $jsonPathArray[0]
                $newJsonObject = $JsonObject.psobject.properties[$current].value

                if ( ($null -eq $newJsonObject) -and $MustExist )  {
                    throw
                }
                $newJsonPathArray = $jsonPathArray[1..($jsonPathArray.length - 1)]
                $newJsonPath = $newJsonPathArray -Join "."

                if ( $MustExist ) {
                    PSSIM.Functions.FindJsonPath -JsonObject $newJsonObject -JsonPath $newJsonPath -MustExist
                }
                else {
                    PSSIM.Functions.FindJsonPath -JsonObject $newJsonObject -JsonPath $newJsonPath
                }
            }
            else {
                try {
                    $value = $JsonObject.psobject.properties[$JsonPath].value
                }
                catch {
                    $value = $null
                }

                if ( ($null -eq $value) -and $MustExist )  {
                    throw
                } else {
                    return $value
                }
            }
        }
        catch {
            $msg = $("Can't find Json path '$JsonPath'")
            throw $msg
        }
    }
}
