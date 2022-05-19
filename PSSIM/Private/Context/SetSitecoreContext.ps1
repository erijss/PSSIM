function PSSIM.Context.SetSitecoreContext {
    <#
    .SYNOPSIS
        Sets all the Sitecore variables
    .DESCRIPTION
    .EXAMPLE
    .INPUTS
    .OUTPUTS
    .NOTES
    #>
    process {
        $config =  $PSSIM.Configuration

        $sitecore = @{}

        $sitecore.Prefix = $($config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.prefix" | PSSIM.Helpers.GetValue).ToUpper()
        $sitecore.Topology = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.topology" | PSSIM.Helpers.GetValue
        $sitecore.Version = $($config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.version" | PSSIM.Helpers.GetValue).Replace(".","")
        $sitecore.Folder = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.folder" | PSSIM.Helpers.GetValue

        if( (Test-Path -Path $sitecore.Folder) -eq $false )
        {
            $msg = "Folder '{0}' does not exit. Set to the correct folder where sites will be installed." -f $sitecore.Folder
            throw $msg
        }

        $sitecore.Folder = Join-Path -Path $sitecore.Folder -ChildPath $sitecore.Prefix

        $sitecore.LicenseFile = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.license" | PSSIM.Helpers.GetValue
        # $sitecore.LicenseFile = [System.IO.Path]::Combine($PSSIM.Context.Settings.WorkingDirectory, $sitecore.LicenseFile)
        $sitecore.LicenseFile = [System.IO.Path]::GetFullPath($sitecore.LicenseFile)

        if( (Test-Path -Path $sitecore.LicenseFile -PathType Leaf) -eq $false )
        {
            throw $("File '$sitecore.LicenseFile.Value' does not exit on the path set in the parameters file.")
        }

        $sitecore.Hostnames = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.hostnames" | PSSIM.Helpers.GetValue
        $sitecore.DatabasesPassword = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.databasespassword" | PSSIM.Helpers.GetValue
        $sitecore.HostNamePattern = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.hostnamepattern" | PSSIM.Helpers.GetValue

        $roles = @{}

        $identity = @{}
        $identity.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.identity.identifier" | PSSIM.Helpers.GetValue
        $identity.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $identity.Identifier
        $identity.Url = "https://" + $identity.Hostname
        $identity.Folder = [System.IO.Path]::Combine($sitecore.Folder,$identity.Hostname)
        $identity.ClientSecret = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.identity.clientsecret" | PSSIM.Helpers.GetValue
        $roles.Identity = $identity

        $cm = @{}
        $cm.Identifier =  $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.contentmanagement.identifier" | PSSIM.Helpers.GetValue
        $cm.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $cm.Identifier
        $cm.Url = "https://" + $cm.Hostname
        $cm.Folder = [System.IO.Path]::Combine($sitecore.Folder,$cm.Hostname)
        $cm.AdminPassword = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.contentmanagement.adminpassword" | PSSIM.Helpers.GetValue
        $roles.Cm = $cm

        $cd = @{}
        $cd.Identifier =  $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.contentdelivery.identifier" | PSSIM.Helpers.GetValue
        $cd.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $cd.Identifier
        $cd.Url = "https://" + $cd.Hostname
        $cd.Folder = [System.IO.Path]::Combine($sitecore.Folder,$cd.Hostname)
        $cd.Bindings = $PSSIM.Context.Project.Hostnames -Join "|"
        $roles.Cd = $cd

        $horizon = @{}
        $horizon.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.horizon.identifier" | PSSIM.Helpers.GetValue
        $horizon.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $horizon.Identifier
        $horizon.Folder = [System.IO.Path]::Combine($sitecore.Folder,$horizon.Hostname)
        $horizon.Url = "https://" + $horizon.Hostname
        $horizon.EnableSXA = [bool]($config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.horizon.enablesxa" | PSSIM.Helpers.GetValue)
        $horizon.EnableContentHub = [bool]($config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.horizon.enablecontenthub" | PSSIM.Helpers.GetValue)
        $roles.Horizon = $horizon

        $pub = @{}
        $pub.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.publishing.identifier" | PSSIM.Helpers.GetValue
        $pub.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $pub.Identifier
        $pub.Folder = [System.IO.Path]::Combine($sitecore.Folder,$pub.Hostname)
        $pub.Url = "https://" + $pub.Hostname
        $roles.Pub = $pub

        $prc = @{}
        $prc.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.processing.identifier" | PSSIM.Helpers.GetValue
        $prc.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $prc.Identifier
        $prc.Folder = [System.IO.Path]::Combine($sitecore.Folder,$prc.Hostname)
        $prc.Url = "https://" + $prc.hostname
        $roles.Prc = $prc

        $rep = @{}
        $rep.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.reporting.identifier" | PSSIM.Helpers.GetValue
        $rep.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $rep.Identifier
        $rep.Url = "https://" + $rep.hostname
        $rep.Folder = [System.IO.Path]::Combine($sitecore.Folder,$rep.Hostname)
        $rep.ApiKey = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.reporting.apikey" | PSSIM.Helpers.GetValue
        $roles.Rep = $rep

        $dds = @{}
        $dds.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.emaildispatch.identifier" | PSSIM.Helpers.GetValue
        $dds.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $dds.Identifier
        $dds.Url = "https://" + $dds.hostname
        $dds.Folder = [System.IO.Path]::Combine($sitecore.Folder,$dds.Hostname)
        $dds.exmcryptographickey = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.emaildispatch.exmcryptographickey" | PSSIM.Helpers.GetValue
        $dds.exmauthenticationkey = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.emaildispatch.exmauthenticationkey" | PSSIM.Helpers.GetValue
        $roles.Dds = $dds

        $xccollect = @{}
        $xccollect.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.xconnectcollect.identifier" | PSSIM.Helpers.GetValue
        $xccollect.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $xccollect.Identifier
        $xccollect.Url = "https://" + $xccollect.hostname
        $prc.Folder = [System.IO.Path]::Combine($sitecore.Folder,$prc.Hostname)
        $roles.XcCollect = $xccollect

        $xcsearch = @{}
        $xcsearch.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.xconnectsearch.identifier" | PSSIM.Helpers.GetValue
        $xcsearch.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $xcsearch.Identifier
        $xcsearch.Url = "https://" + $xcsearch.hostname
        $xcsearch.Folder = [System.IO.Path]::Combine($sitecore.Folder,$xcsearch.Hostname)
        $roles.XcSearch = $xcsearch

        $xcrefdata = @{}
        $xcrefdata.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.xconnectrefdata.identifier" | PSSIM.Helpers.GetValue
        $xcrefdata.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $xcrefdata.Identifier
        $xcrefdata.Url = "https://" + $xcrefdata.hostname
        $xcrefdata.Folder = [System.IO.Path]::Combine($sitecore.Folder,$xcrefdata.Hostname)
        $roles.XcRefdata = $xcrefdata

        $maops = @{}
        $maops.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.MarketingAutomationOperations.identifier" | PSSIM.Helpers.GetValue
        $maops.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $maops.Identifier
        $maops.Url = "https://" + $maops.hostname
        $maops.Folder = [System.IO.Path]::Combine($sitecore.Folder,$maops.Hostname)
        $roles.MaOps = $maops

        $marep = @{}
        $marep.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.MarketingAutomationReporting.identifier" | PSSIM.Helpers.GetValue
        $marep.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $marep.Identifier
        $marep.Url = "https://" + $marep.hostname
        $marep.Folder = [System.IO.Path]::Combine($sitecore.Folder,$marep.Hostname)
        $roles.MaRep = $marep

        $cortexprc = @{}
        $cortexprc.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.CortexProcessing.identifier" | PSSIM.Helpers.GetValue
        $cortexprc.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $cortexprc.Identifier
        $cortexprc.Url = "https://" + $cortexprc.hostname
        $cortexprc.Folder = [System.IO.Path]::Combine($sitecore.Folder,$cortexprc.Hostname)
        $roles.CortexPrc = $cortexprc

        $cortexrep = @{}
        $cortexrep.Identifier = $config | PSSIM.Functions.FindJsonPath -JsonPath "sitecore.roles.CortexReporting.identifier" | PSSIM.Helpers.GetValue
        $cortexrep.Hostname = PSSIM.Helpers.GetHostname -Pattern $sitecore.HostNamePattern -Prefix $sitecore.Prefix -Identifier $cortexrep.Identifier
        $cortexrep.Url = "https://" + $cortexrep.hostname
        $cortexrep.Folder = [System.IO.Path]::Combine($sitecore.Folder,$cortexrep.Hostname)
        $roles.CortexRep = $cortexrep

        $sitecore.Roles = $roles
        $PSSIM.Context.Sitecore = $sitecore
    }
}
