function PSSIM.Sitecore.UnInstallConfiguration {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [PSObject]
        $Parameters,
        [Parameter()]
        [string]
        $LogFileNameAddition,
        [Parameter()]
        [string]
        $SIFFolder,
        [Parameter()]
        [boolean]
        $VerboseOutput = $false
    )
    process {
        $timestamp = (Get-Date).ToString('yyyyMMddhhmmss')
        if ( ($null -eq $LogFileNameAddition) -or ($LogFileNameAddition -eq "" ) ) {
            $logFileName = "$($timestamp)_UnInstallSitecoreConfiguration.log"
        }
        else {
            $logFileName = "$($timestamp)_UnInstallSitecoreConfiguration_$($LogFileNameAddition).log"
        }
        $logFilePath = $PSSIM.Context.Settings.WorkingDirectory
        $LogFile = Join-Path $logFilePath $logFileName

        $SIFPath = [System.IO.Path]::Combine($PSSIM.Info.ModulePath, "SIF", $PSSIM.Context.Sitecore.Version, $SIFFolder)

        Push-Location $SIFPath

        try {
            if ( $VerboseOutput ) {
                UnInstall-SitecoreConfiguration @Parameters -Verbose *>&1 | Tee-Object $LogFile
            }
            else {
                UnInstall-SitecoreConfiguration @Parameters *>&1 | Tee-Object $LogFile
            }
        }
        catch {
            PSSIM.UserInteraction.WriteError $_
        }
        finally {
            Pop-Location
        }
    }
}
