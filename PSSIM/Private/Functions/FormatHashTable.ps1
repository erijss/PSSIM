function PSSIM.Functions.FormatHashTable
    <#
    .SYNOPSIS
    # Pretty-prints a (nested) hash table
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
{
    param
    (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [System.Collections.IDictionary[]]$HashTable,

        [ValidateRange(0, [int]::MaxValue)]
        [int]$Indentation = 0
    )

    process
    {
        foreach ($Item in $HashTable)
        {
            foreach ($Key in $Item.Keys)
            {
                $Value = $Item["$Key"]

                if ($Value -is [hashtable] -or $Value -is [System.Collections.Specialized.OrderedDictionary])
                {
                    Write-Output "$(" " * $Indentation)$Key"
                    PSSIM.Functions.FormatHashTable -HashTable $Value -Indentation ($Indentation + 1)
                }
                else
                {
                    Write-Output "$(" " * $Indentation)$Key = $Value"
                }
            }
        }
    }
}
