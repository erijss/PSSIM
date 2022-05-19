function PSSIM.Context.SetCertificatesContext {
    <#
    .SYNOPSIS
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    process {
        $config =  $PSSIM.Configuration

        $certificates = @{}

        $certificates.Folder = $config | PSSIM.Functions.FindJsonPath -JsonPath "certificates.folder" | PSSIM.Helpers.GetValue
        $certificates.Password = $config | PSSIM.Functions.FindJsonPath -JsonPath "certificates.password" | PSSIM.Helpers.GetValue
        $certificates.RootCertificate = $config | PSSIM.Functions.FindJsonPath -JsonPath "certificates.rootcertificate" | PSSIM.Helpers.GetValue

        $PSSIM.Context.Certificates = $certificates
    }
}
