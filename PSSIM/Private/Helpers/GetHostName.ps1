function PSSIM.Helpers.GetHostName {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    param (
        [Parameter()]
        [String]
        $Pattern,
        [Parameter()]
        [String]
        $Prefix,
        [Parameter()]
        [String]
        $Identifier
    )
    process {
        $hostName = $pattern.Replace("{{prefix}}",$Prefix.ToLower()).Replace("{{identifier}}",$Identifier.ToLower())
        return $hostName
    }
}
