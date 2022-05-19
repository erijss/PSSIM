function Get-PSSIMParametersFile {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    param (
        # Switch to to get the undocumented version of the PSSIM_Parameters.json file.
        [Parameter(
            HelpMessage = "Switch to to get the undocumented version of the PSSIM_Parameters.json file"
        )]
        [switch]
        $Undocumented,

        # Specifies a path to one or more locations. Wildcards are permitted.
        [Parameter(
            HelpMessage = "Path to save the PSSIM_Parameters.json file to."
        )]
        [string]
        $Path = ".\PSSIM-Parameters.json"
    )
    process {
        if ( $Undocumented ) {
            $ourceName = "PSSIM-Parameters-UnDocumented.json"
        }
        else {
            $ourceName = "PSSIM-Parameters-Documented.json"
        }


        $ource = [System.IO.Path]::Combine($PSSIM.Info.ModulePath, "Assets", $ourceName)

        $fullPath = [System.IO.Path]::GetFullPath($Path)
        $msg = "Type the path where the parameters file should be saved to.`nIf empty it will be saved to the current folder ($fullPath)"
        $target = Read-Host -Prompt $msg

        $target = ($Path, $target)[[bool]$target]

        $targetFileName = Split-Path -Path $target -Leaf
        if (  $targetFileName.IndexOf(".") -gt 0 ) {
            $targetFolder = Split-Path -Path $target
        }
        else {
            $targetFolder = $target
            $targetFileName = "PSSIM-Parameters.json"
        }

        $target = [System.IO.Path]::Combine($targetFolder, $targetFileName)


        if ( Test-Path -Path $targetFolder ) {
            # Do Nothing, folder exists
        }
        else {
            Write-Warning "That folder does not exist"
            # setup question and choices
            $question = "Do you want to create that folder?"
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&Yes", "Type 'Y' to create to folder"))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&No", "Type 'N' to exit"))
            $decision = $Host.UI.PromptForChoice($question, $null, $choices, -1)

            if ( $decision -eq 0) {
                New-Item -ItemType "directory" -Path $targetFolder | Out-Null
            }
            else {
                return
            }
        }

        if ( Test-Path -Path $target ) {
            Write-Warning "File $targetFileName already exists in that folder"
            # setup question and choices
            $question = "Do you want to overwrite this file?"
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&Yes", "Type 'Y' to create to folder"))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&No", "Type 'N' to exit"))
            $decision = $Host.UI.PromptForChoice($question, $null, $choices, -1)

            if ( $decision -eq 0) {
                Copy-Item -Path $ource -Destination $target -Force | Out-Null
                Write-Host ""
                Write-Host "The parameters file is written to $target"
                Write-Host ""
            }
            else {
                return
            }
        }
        else {
            if ( $targetFileName -eq "" ) {
                Write-Warning "No valid filename given"
            }
            else {
                Copy-Item -Path $ource -Destination $target | Out-Null
                Write-Host ""
                Write-Host "The parameters file is written to $target"
                Write-Host ""
            }
        }
    }
}
