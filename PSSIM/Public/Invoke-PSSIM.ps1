function Invoke-PSSIM {
    <#
    .SYNOPSIS
        Invoke the Json menu definition to run a menu in the console or as a system tray menu
    .DESCRIPTION
        Invoke-Menu creates a menu based on structured Json format. The Json contains definitions for menu optinos
    .EXAMPLE
        PS C:\> <example usage>
        Explanation of what the example does
    .INPUTS
        Input (if any)
    .OUTPUTS
        Output (if any)
    .NOTES
        General notes
    #>
    param (
    )
    process {
        PSSIM.UserInteraction.ClearHost -Cls $true
        PSSIM.UserInteraction.WriteLogo

        if (Get-Module -ListAvailable -Name "JsonMenu") {
            #  JsonMenu module exists
        }
        else {
            $question = "Invoke-PSSIM is depenendent on the PowerShell module 'JsonMenu'. Do you want to install this module?"
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&Yes", "Type 'Y' to install"))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&No", "Type 'N' to exit"))

            # prompt for choice and wait for user input
            $decision = $Host.UI.PromptForChoice($question, $null, $choices, -1)

            # return user input
            if ($decision -eq 0) {
                Install-Module "JsonMenu" -Force
            }
            else {
                return
            }
        }

        if (Get-Module -ListAvailable -Name "JsonMenu") {
            $menu = [System.IO.Path]::Combine($PSSIM.Info.ModulePath,"Menu","PSSIM_Menu.json")
            Invoke-JsonMenu  -Path $menu
        }

    }
}
