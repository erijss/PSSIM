function PSSIF.UserInteraction.WriteLogo {
    <#
    .SYNOPSIS
        Writes the logo
    .DESCRIPTION
        The steps are:
        - Get version from PSSIFContext and write logo
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
        if ( $PSSIF.Context.Settings.NoLogo ) {
            #no logo
        }
        else {

            $line1 = " \\==== ".PadLeft(2)
            $line2a = " //==== ".PadLeft(2)
            $line2b = "    PSSIF version {0}" -f $PSSIF.Info.Version
            $line3a = "//===== ".PadLeft(2)

            $currentYear = (Get-Date).Year
            if ( $currentYear -gt $PSSIF.Info.Created) {
                $line3b = "    Copyright (c) 2020-{0}, Erwin Rijss" -f $currentYear
            }
            else {
                $line3b = "    Copyright (c) 2020, Erwin Rijss"
            }

            Write-Host $line1 -BackgroundColor DarkRed
            Write-Host $line2a -BackgroundColor DarkRed -NoNewline
            Write-Host $line2b
            Write-Host $line3a -BackgroundColor DarkRed -NoNewline
            Write-Host $line3b

            Start-Sleep $PSSIF.Info.ShowLogo
        }
    }
}
