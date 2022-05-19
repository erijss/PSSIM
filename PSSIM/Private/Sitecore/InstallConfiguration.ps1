function PSSIM.Sitecore.InstallConfiguration {
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
        $VerboseOutput = $false,
        [Parameter()]
        [PSObject]
        $Skip
    )
    process {
        $timestamp = (Get-Date).ToString('yyyyMMddhhmmss')
        if ( ($null -eq $LogFileNameAddition) -or ($LogFileNameAddition -eq "" ) ) {
            $logFileName = "$($timestamp)_InstallSitecoreConfiguration.log"
        }
        else {
            $logFileName = "$($timestamp)_InstallSitecoreConfiguration_$($LogFileNameAddition).log"
        }
        $logFilePath = $PSSIM.Context.Settings.WorkingDirectory
        $LogFile = Join-Path $logFilePath $logFileName

        $SIFPath = [System.IO.Path]::Combine($PSSIM.Info.ModulePath, "SIF", $PSSIM.Context.Sitecore.Version, $SIFFolder)
        Push-Location $SIFPath

        try {
            if ($Skip.Count -eq 0) {
                if ( $VerboseOutput ) {
                    Install-SitecoreConfiguration @Parameters -Verbose *>&1 | Tee-Object $LogFile
                }
                else {
                    Install-SitecoreConfiguration @Parameters *>&1 | Tee-Object $LogFile
                }
            }
            else {
                if ( $VerboseOutput ) {
                    Install-SitecoreConfiguration @Parameters -Skip $Skip -Verbose *>&1 | Tee-Object $LogFile
                }
                else {
                    Install-SitecoreConfiguration @Parameters -Skip $Skip  *>&1 | Tee-Object $LogFile
                }
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
