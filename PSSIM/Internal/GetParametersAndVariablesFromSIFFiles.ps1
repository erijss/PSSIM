function ConvertToHashtable
{
    [CmdletBinding()]
    [OutputType('hashtable')]
    param (
        [Parameter(ValueFromPipeline)]
        $InputObject
    )
    process
    {
        ## Return null if the input is null. This can happen when calling the function
        ## recursively and a property is null
        if ($null -eq $InputObject)
        {
            return $null
        }
        ## Check if the input is an array or collection. If so, we also need to convert
        ## those types into hash tables as well. This function will convert all child
        ## objects into hash tables (if applicable)
        if ($InputObject -is [System.Collections.IEnumerable] -and $InputObject -isnot [string])
        {
            $collection = @(
                foreach ($object in $InputObject)
                {
                    ConvertToHashtable -InputObject $object
                }
            )
            ## Return the array but don't enumerate it because the object may be pretty complex
            # Write-Output -NoEnumerate $collection
        }
        elseif ($InputObject -is [psobject])
        {
            ## If the object has properties that need enumeration
            ## Convert it to its own hash table and return it
            $hash = @{}
            foreach ($property in $InputObject.PSObject.Properties)
            {
                $hash[$property.Name] = ConvertToHashtable -InputObject $property.Value
            }
            $hash
        }
        else
        {
            ## If the object isn't an array, collection, or other object, it's already a hash table
            ## So just return it.
            $InputObject
        }
    }
}

function WriteParameters
{
    param (
        [Parameter()]
        [switch]
        $InterfaceFiles,
        [Parameter()]
        [string]
        $Topology,
        [Parameter()]
        [string]
        $AsPowerShell
    )

    Write-Host ""
    Write-Host "============================  Writing Parameters  ======================================"

    $rootFolder = [System.IO.Path]::Combine($MyInvocation.PSScriptRoot, ".\..\SIF") | Convert-Path
    if ( $InterfaceFiles) { $filter = "$Topology*Single*.json" } else { $filter = "*.json" }

    $output = @()

    Get-ChildItem -Path $rootFolder -Recurse -Include $filter | Sort-Object { [Int]$_.Directory.Parent.Name } | Foreach-Object {

        if ( $InterfaceFiles) { $output = @() }

        $version = $_.Directory.Parent
        $filename = $_.Name

        Write-Host "Parameters | Version: $version | File: $fileName | " -NoNewline

        if ( -not $InterfaceFiles )
        {
            $output += "File: $fileName"
            $output += "Version: $version"
            $output += "----------------------------------------------------------------------------"
        }

        $rawsifparameters = ((Get-Content -Path $_.FullName  -Force -Raw).Where({ $_ -notmatch '^\s*\/\/' }) | Out-String | ConvertFrom-Json).Parameters
        if ( $null -ne $rawsifparameters)
        {
            $sifparameters = ($rawsifparameters | ConvertToHashtable).GetEnumerator() | Sort-Object -Property "Name"
        }
        else
        {
            $sifparameters = @{}
        }


        # Main Parameters of the JSON file
        foreach ($sifparameter in $sifparameters.GetEnumerator())
        {
            if ( -not $AsPowerShell ) {
                if ( -not $sifparameter.Name.Contains(":") ) { $output += $sifparameter.Name }
            }
            else {
                $line = '$parameters.Add("{0}","")' -f $sifparameter.Name
                if ( -not $sifparameter.Name.Contains(":") ) { $output += $line }
            }
        }

        if (-not $InterfaceFiles)
        {
            # Delegated Parameters of the JSON file (only for "UI" files (files with Single or Distributed in the name))
            foreach ($sifparameter in $sifparameters.GetEnumerator())
            {
                if ( $sifparameter.Name.Contains(":") ) { $output += $sifparameter.Name }
            }
        }

        if ( -not $InterfaceFiles )
        {
            $output += ""
            Write-Host "Done" -ForegroundColor Green
        }
        else
        {
            $filename = $_.BaseName + "_" + $version + ".text"
            $folder = $MyInvocation.PSScriptRoot
            $filepath = [System.IO.Path]::Combine($folder, "Output", $Topology, $filename)
            $output | Out-File -FilePath $filepath -Force
            Write-Host "Done" -ForegroundColor Green
        }
    }

    if ( -not $InterfaceFiles )
    {
        $filename = "All_Parameters.text"
        $folder = $MyInvocation.PSScriptRoot
        $filepath = [System.IO.Path]::Combine($folder,"Output", $filename)
        $output | Out-File -FilePath $filepath -Force
    }

    Write-Host "--------------------------  Done Writing Parameters  -----------------------------------"
    Write-Host ""


}

function WriteVariables
{

    Write-Host ""
    Write-Host "============================  Writing Variables  ======================================"

    $rootFolder = [System.IO.Path]::Combine($MyInvocation.PSScriptRoot, ".\..\SIF") | Convert-Path
    $filter = "*.json"

    $output = @()

    Get-ChildItem -Path $rootFolder -Recurse -Include $filter | Sort-Object { [Int]$_.Directory.Parent.Name } | Foreach-Object {

        $version = $_.Directory.Parent
        $filename = $_.Name

        Write-Host "Variables | Version: $version | File: $fileName | " -NoNewline

        if ( -not $InterfaceFiles )
        {
            $output += "File: $fileName"
            $output += "Version: $version"
            $output += "----------------------------------------------------------------------------"
        }

        $rawsifparameters = ((Get-Content -Path $_.FullName  -Force -Raw).Where({ $_ -notmatch '^\s*\/\/' }) | Out-String | ConvertFrom-Json).Variables
        if ( $null -ne $rawsifparameters)
        {
            $sifparameters = ($rawsifparameters | ConvertToHashtable).GetEnumerator() | Sort-Object -Property "Name"
        }
        else
        {
            $sifparameters = @{}
        }

        # Main Parameters of the JSON file
        foreach ($sifparameter in $sifparameters.GetEnumerator())
        {
            if ( -not $sifparameter.Name.Contains(":") ) { $output += ($sifparameter.Name ) }
        }
        # Delegated Parameters of the JSON file (only for "UI" files (files with Single or Distributed in the name))
        foreach ($sifparameter in $sifparameters.GetEnumerator())
        {
            if ( $sifparameter.Name.Contains(":") ) { $output += ($sifparameter.Name) }
        }

        $output += ""

        Write-Host "Done" -ForegroundColor Green
    }

    $filename = "All_Variables.text"
    $folder = $MyInvocation.PSScriptRoot
    $filepath = [System.IO.Path]::Combine($folder, "Output", $filename)
    $output | Out-File -FilePath $filepath -Force

    Write-Host "--------------------------  Done Writing Variables  -----------------------------------"
    Write-Host ""

}

WriteParameters -Topology XM0 -InterfaceFiles
WriteParameters -Topology XM1 -InterfaceFiles
WriteParameters -Topology XP0 -InterfaceFiles
WriteParameters -Topology XP1 -InterfaceFiles
WriteParameters -Topology SXA -InterfaceFiles
WriteParameters -Topology SHS -InterfaceFiles
WriteParameters
WriteVariables
