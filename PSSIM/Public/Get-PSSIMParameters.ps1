function Get-PSSIMParameters {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    param (
    )
    process {

        Write-Host "==============================================================="
        Write-Host ""
        Write-Host "PSSIM Parameters"
        Write-Host "                                                               "
        Write-Host "Loaded parameters file: $($PSSIM.Context.File.Name)"
        Write-Host "From folder           : $($PSSIM.Context.File.Name)"
        Write-Host "                                                               "
        Write-Host "==============================================================="
        Write-Host "-------------------------- SITECORE ---------------------------"
        PSSIM.Functions.FormatHashTable -HashTable $PSSIM.Context.Sitecore -Indentation 0
        Write-Host ""
        Write-Host "---------------------------- SOLR -----------------------------"
        PSSIM.Functions.FormatHashTable -HashTable $PSSIM.Context.Solr -Indentation 0
        Write-Host ""
        Write-Host "------------------------- SQL SERVER --------------------------"
        PSSIM.Functions.FormatHashTable -HashTable $PSSIM.Context.SqlServer -Indentation 0
        Write-Host ""
        Write-Host "-------------------------- RESOURCES --------------------------"
        PSSIM.Functions.FormatHashTable -HashTable $PSSIM.Context.Resources -Indentation 0
        Write-Host ""
        Write-Host "---------------------------- File ----------------------=------"
        PSSIM.Functions.FormatHashTable -HashTable $PSSIM.Context.File -Indentation 0
        Write-Host ""
    }
}
