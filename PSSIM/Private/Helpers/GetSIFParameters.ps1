function PSSIM.Functions.ConvertToHashtable {
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    process {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject) {
            return $null
        }
        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string]) {
            $collection = @(
                foreach ($object in $InputObject) {
                    PSSIM.Functions.ConvertToHashtable -InputObject $object
                }
            )
            ## Return the array but don't enumerate it because the object may be pretty complex
            # Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject]) {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties) {
                $hash[$property.Name] = PSSIM.Functions.ConvertToHashtable -InputObject $property.Value
            }
            $hash
        }
        else {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}

function WriteParameters () {
    $output = @()
    $rootFolder = [System.IO.Path]::Combine($MyInvocation.PSScriptRoot, "..\..\SIF") | Convert-Path
    Get-ChildItem -Path $rootFolder -Recurse -Include "*.json" | Sort-Object { [Int]$_.Directory.Parent.Name } | Foreach-Object {
        $version = $_.Directory.Parent
        $name = $_.Name

        Write-Host "Getting Parameter of $name"

        $output += ("$version - $name")
        $output += ("=========================================================================================================")

        $parameters = ((Get-Content -Path $_.FullName  -Force -Raw | ConvertFrom-Json).Parameters | PSSIM.Functions.ConvertToHashtable).GetEnumerator() | Sort-Object -Property "Name"

        foreach ($parameter in $parameters.GetEnumerator()) {
            if ( $parameter.Name.Contains(":") ) {
            }
            else {
                $output += ($parameter.Name)
            }
        }
        $output += ("")

        Write-Host "Parameters of $name added to output"

    }
    $output | Out-File -FilePath "D:\parameters.txt" -Force

}

function WriteVariables () {
    $output = @()
    $rootFolder = [System.IO.Path]::Combine($MyInvocation.PSScriptRoot, "..\..\SIF") | Convert-Path
    Get-ChildItem -Path $rootFolder -Recurse -Include "*.json" | Sort-Object { [Int]$_.Directory.Parent.Name } | Foreach-Object {
        $version = $_.Directory.Parent
        $name = $_.Name

        Write-Host "Getting Variables of $name"

        $output += ("$version - $name")
        $output += ("=========================================================================================================")

        $parameters = ((Get-Content -Path $_.FullName  -Force -Raw | ConvertFrom-Json).Variables | PSSIM.Functions.ConvertToHashtable).GetEnumerator() | Sort-Object -Property "Name"

        foreach ($parameter in $parameters.GetEnumerator()) {
            if ( $parameter.Name.Contains(":") ) {
            }
            else {
                $output += ($parameter.Name)
            }
        }
        $output += ("")

        Write-Host "Variables of $name added to output"

    }
    $output | Out-File -FilePath "D:\variables.txt" -Force

}

WriteParameters
WriteVariables
