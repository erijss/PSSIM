function PSSIM.UserInteraction.WriteLogo {
    <#
    .SYNOPSIS
        Writes the logo
    .DESCRIPTION
        The steps are:
        - Get version from PSSIMContext and write logo
        - Wait 2 seconds
    .EXAMPLE
        none
    .INPUTS
        none
    .OUTPUTS
        none
    .NOTES
    #>
    process {
        if ( $PSSIM.Context.Settings.NoLogo ) {
            #no logo
        }
        else {

            $line1 = "       "
            $line2a = " "
            $line2b = "PSSIM"
            $line2c = " "
            $line2d = "    PSSIM version {0}" -f $PSSIM.Info.Version
            $line3a = "       "

            $currentYear = (Get-Date).Year
            if ( $currentYear -gt $PSSIM.Info.Created)
            {
                $line3b = "    Copyright (c) 2022-{0}, Erwin Rijss" -f $currentYear
            }
            else
            {
                $line3b = "    Copyright (c) 2022, Erwin Rijss"
            }

            Write-Host $line1 -BackgroundColor Yellow
            Write-Host $line2a -BackgroundColor Yellow -NoNewline
            Write-Host $line2b -BackgroundColor Yellow -ForegroundColor Black -NoNewline
            Write-Host $line2c -BackgroundColor Yellow -NoNewline
            Write-Host $line2d
            Write-Host $line3a -BackgroundColor Yellow -NoNewline
            Write-Host $line3b
            Write-Host " "

            Start-Sleep $PSSIM.Info.ShowLogo
        }
    }
}
