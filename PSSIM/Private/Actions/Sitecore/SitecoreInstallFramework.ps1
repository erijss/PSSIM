function PSSIM.Action.SitecoreInstallFramework {
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
        if (  Get-PSRepository "SitecoreGallery" ){
            # Do nothing. SitecoreGallery PSRepository exists
        }
        else {
            $question = "Sitecore Install Framework is in the Sitecore Powershell Gallery which is not registred. Do you want tor register it?"
            $choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&Yes", "Type 'Y' to register SitecoreGallery PowerShell repository"))
            $choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList "&No", "Type 'N' to exit"))

            # prompt for choice and wait for user input
            $decision = $Host.UI.PromptForChoice($question, $null, $choices, -1)

            # return user input
            if ($decision -eq 0) {
                Register-PSRepository -Name SitecoreGallery -SourceLocation https://sitecore.myget.org/F/sc-powershell/api/v2
            }
            else {
                Write-Warning "If you don't install the Sitecore PowerShell Gallery, Sitecore Install Framework cannot be installed either"
                return
            }
        }

        Install-Module "SitecoreInstallFramework" -Force
    }
}
