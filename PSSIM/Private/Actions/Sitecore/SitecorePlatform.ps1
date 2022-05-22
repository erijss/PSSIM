function PSSIM.Action.SitecorePlatform {
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

        $parameters = @{}

        switch ( $PSSIM.Context.Sitecore.Topology ) {
            "XM0" {
                $parameters.Add("Path", "XM0-SingleDeveloper.json")
                $parameters.Add("AppLicenseFile", $PSSIM.Context.Sitecore.LicenseFile)
                $parameters.Add("AppPrefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("AppFolder", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("ContentDeliveryDisableHttps", $false)
                $parameters.Add("ContentManagementAppName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("ContentManagementPackage",  $PSSIM.Context.Resources.Packages.SITECORE_XM1_CM.Path)
                $parameters.Add("DatabaseCorePassword",  $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("DatabaseFormsPassword",  $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("DatabaseMasterPassword",  $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("DatabaseSecurityPassword",  $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("DatabaseWebPassword",  $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("IdentityServerAllowedCorsOrigins", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("IdentityServerAppName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("IdentityServerCertificateName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("IdentityServerClientsConfiguration", "")
                $parameters.Add("IdentityServerClientSecret", $PSSIM.Context.Sitecore.Roles.Identity.ClientSecret)
                $parameters.Add("IdentityServerPackage",  $PSSIM.Context.Resources.Packages.SITECORE_IDENTITY.Path)
                $parameters.Add("IdentityServerPasswordRecoveryUrl", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("PackagesDownloadLocations", ".\filethatdoesnotexist.json")
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SitecoreIdentityAuthority", $PSSIM.Context.Sitecore.Roles.Identity.Url)
                $parameters.Add("SolrFolder", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SqlServerAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SqlServerAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlServerDeployToElasticPoolName", "")
                $parameters.Add("SqlServerInstance", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("Update", $PSSIM.Context.Settings.Update)
            }
            # "XM0" {
            #     $parameters.Add("Path", "XM0-SingleDeveloper.json")
            #     # $parameters.Add("CertPath", $PSSIM.Context.Certificates.Folder)
            #     # $parameters.Add("RootCertFileName", $PSSIM.Context.Certificates.RootCertificate)
            #     # $parameters.Add("ExportPassword", $PSSIM.Context.Certificates.Password)
            #     $parameters.Add("LicenseFile", $PSSIM.Context.Sitecore.LicenseFile)
            #     $parameters.Add("IdentityServerCertificateName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
            #     $parameters.Add("IdentityServerSiteName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
            #     $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
            #     $parameters.Add("SitecoreContentManagementSiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
            #     # $parameters.Add("ContentManagementCertificateName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
            #     $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
            #     $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
            #     $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
            #     $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
            #     $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
            #     $parameters.Add("SqlFormsPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
            #     $parameters.Add("SqlSecurityPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
            #     $parameters.Add("SqlCorePassword", $PSSIM.Context.Sitecore.DatabasesPassword)
            #     $parameters.Add("SqlMasterPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
            #     $parameters.Add("SqlWebPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
            #     $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
            #     $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
            #     $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
            #     $parameters.Add("SitecoreContentManagementPackage", $PSSIM.Context.Resources.Packages.SITECORE_XM1_CM.Path)
            #     $parameters.Add("IdentityServerPackage", $PSSIM.Context.Resources.Packages.SITECORE_IDENTITY.Path)
            #     $parameters.Add("PasswordRecoveryUrl", $PSSIM.Context.Sitecore.Roles.CM.Url)
            #     $parameters.Add("ClientsConfiguration", "")
            #     $parameters.Add("AllowedCorsOrigins", $PSSIM.Context.Sitecore.Roles.CM.Url)
            #     $parameters.Add("ClientSecret", $PSSIM.Context.Sitecore.Roles.Identity.ClientSecret)
            #     $parameters.Add("SitecoreIdentityAuthority", $PSSIM.Context.Sitecore.Roles.Identity.Url)
            #     $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
            #     $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
            #     $parameters.Add("DisableHttpsForCD", $false)
            #     $parameters.Add("Update", $PSSIM.Context.Settings.Update)
            #     $parameters.Add("DeployToElasticPoolName", "")
            # }
            "XM1" {
                $parameters.Add("Path", "XM1-SingleDeveloper.json")
                $parameters.Add("LicenseFile", $PSSIM.Context.Sitecore.LicenseFile)
                $parameters.Add("IdentityServerCertificateName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("IdentityServerSiteName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SitecoreContentManagementSiteName", $PSSIM.Context.Sitecore.Roles.CM.Hostname)
                $parameters.Add("SitecoreContentDeliverySiteName", $PSSIM.Context.Sitecore.Roles.CD.Hostname)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("SqlFormsPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlSecurityPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlCorePassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlMasterPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlWebPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("SitecoreContentManagementPackage", $PSSIM.Context.Resources.Packages.SITECORE_XM1_CM.Path)
                $parameters.Add("SitecoreContentDeliveryPackage", $PSSIM.Context.Resources.Packages.SITECORE_XM1_CD.Path)
                $parameters.Add("IdentityServerPackage", $PSSIM.Context.Resources.Packages.SITECORE_IDENTITY.Path)
                $parameters.Add("PasswordRecoveryUrl", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("ClientsConfiguration", "")
                $parameters.Add("AllowedCorsOrigins", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("ClientSecret", $PSSIM.Context.Sitecore.Roles.Identity.ClientSecret)
                $parameters.Add("SitecoreIdentityAuthority", $PSSIM.Context.Sitecore.Roles.Identity.Url)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
                $parameters.Add("DisableHttpsForCD", $false)
                $parameters.Add("Update", $PSSIM.Context.Settings.Update)
                $parameters.Add("DeployToElasticPoolName", "")
            }
            "XP0" {
                $parameters.Add("Path", "XP0-SingleDeveloper.json")
                $parameters.Add("XConnectCertificateName", $PSSIM.Context.Sitecore.Roles.XcCollect.Hostname)
                $parameters.Add("IdentityServerCertificateName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("IdentityServerSiteName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("LicenseFile", $PSSIM.Context.Sitecore.LicenseFile)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("SqlCollectionPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlProcessingPoolsPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlReferenceDataPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlMarketingAutomationPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlMessagingPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlProcessingEnginePassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlReportingPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlCorePassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlSecurityPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlMasterPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlWebPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlProcessingTasksPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlFormsPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlExmMasterPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("XConnectSiteName", $PSSIM.Context.Sitecore.Roles.XcCollect.HostName)
                $parameters.Add("SitecoreSiteName", $PSSIM.Context.Sitecore.Roles.CM.HostName)
                $parameters.Add("PasswordRecoveryUrl", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("SitecorePackage", $PSSIM.Context.Resources.Packages.SITECORE_XP0_SINGLE.Path)
                $parameters.Add("IdentityServerPackage", $PSSIM.Context.Resources.Packages.SITECORE_IDENTITY.Path)
                $parameters.Add("XConnectPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP0_XCONNECT.Path)
                $parameters.Add("XConnectCollectionService", $PSSIM.Context.Sitecore.Roles.XcCollect.Url)
                $parameters.Add("ClientsConfiguration", "")
                $parameters.Add("AllowedCorsOrigins", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("SitecoreIdentityAuthority", $PSSIM.Context.Sitecore.Roles.Identity.Url)
                $parameters.Add("ClientSecret", $PSSIM.Context.Sitecore.Roles.Identity.ClientSecret)
                $parameters.Add("PackagesTempLocation", $PSSIM.Context.Resources.Folder)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
                $parameters.Add("Update", $PSSIM.Context.Settings.Update)
                $parameters.Add("DeployToElasticPoolName", "")
            }
            "XP1" {
                $parameters.Add("Path", "XP1-SingleDeveloper.json")
                $parameters.Add("CertificateName", $PSSIM.Context.Sitecore.Roles.XcCollect.HostName)
                $parameters.Add("IdentityServerCertificateName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("IdentityServerSiteName", $PSSIM.Context.Sitecore.Roles.Identity.Hostname)
                $parameters.Add("LicenseFile", $PSSIM.Context.Sitecore.LicenseFile)
                $parameters.Add("Prefix", $PSSIM.Context.Sitecore.Prefix)
                $parameters.Add("XP1CollectionPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_XCCOLLECT.Path)
                $parameters.Add("XP1CollectionSearchPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_XCSEARCH.Path)
                $parameters.Add("XP1CortexProcessingPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_CORTEXTPRC.Path)
                $parameters.Add("XP1MarketingAutomationPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_MAOPS.Path)
                $parameters.Add("XP1MarketingAutomationReportingPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_MAREP.Path)
                $parameters.Add("XP1CortexReportingPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_CORTEXTREP.Path)
                $parameters.Add("XP1ReferenceDataPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_XCREFDATA.Path)
                $parameters.Add("SitecoreXP1CDPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_CD.Path)
                $parameters.Add("SitecoreXP1CMPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_CM.Path)
                $parameters.Add("SitecoreXP1PrcPackage", $PSSIM.Context.Resources.Packages.SITECORE_XP1_PRC.Path)
                $parameters.Add("IdentityServerPackage", $PSSIM.Context.Resources.Packages.SITECORE_IDENTIT.Path)
                $parameters.Add("XP1CortexProcessingSitename", $PSSIM.Context.Sitecore.Roles.CortexPrc.HostName)
                $parameters.Add("XP1CollectionSitename", $PSSIM.Context.Sitecore.Roles.XcCollect.HostName)
                $parameters.Add("XP1CollectionSearchSitename", $PSSIM.Context.Sitecore.Roles.XcSearch.HostName)
                $parameters.Add("XP1MarketingAutomationSitename", $PSSIM.Context.Sitecore.Roles.MaOps.HostName)
                $parameters.Add("XP1MarketingAutomationReportingSitename", $PSSIM.Context.Sitecore.Roles.MaRep.HostName)
                $parameters.Add("XP1ReferenceDataSitename", $PSSIM.Context.Sitecore.Roles.XcRefdata.HostName)
                $parameters.Add("XP1CortexReportingSitename", $PSSIM.Context.Sitecore.Roles.CortexRep.HostName)
                $parameters.Add("SitecoreXP1CDSitename", $PSSIM.Context.Sitecore.Roles.Cd.HostName)
                $parameters.Add("SitecoreXP1CMSitename", $PSSIM.Context.Sitecore.Roles.Cm.HostName)
                $parameters.Add("SitecoreXP1PrcSitename", $PSSIM.Context.Sitecore.Roles.Prc.HostName)
                $parameters.Add("ProcessingService", $PSSIM.Context.Sitecore.Roles.Prc.Url)
                $parameters.Add("CortexReportingService", $PSSIM.Context.Sitecore.Roles.CortexRep.Url)
                $parameters.Add("CortexProcessingService", $PSSIM.Context.Sitecore.Roles.CortexPrc.Url)
                $parameters.Add("ReportingServiceApiKey", $PSSIM.Context.Sitecore.Roles.Rep.ApiKey)
                $parameters.Add("PasswordRecoveryUrl", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("ClientsConfiguration", "")
                $parameters.Add("SqlAdminUser", $PSSIM.Context.SqlServer.Administrator.Username)
                $parameters.Add("SqlAdminPassword", $PSSIM.Context.SqlServer.Administrator.Password)
                $parameters.Add("SQLServer", $PSSIM.Context.SqlServer.Instance)
                $parameters.Add("SitecoreAdminPassword", $PSSIM.Context.Sitecore.Roles.CM.AdminPassword)
                $parameters.Add("SiteRoot", $PSSIM.Context.Sitecore.Folder)
                $parameters.Add("SqlCorePassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlSecurityPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlMarketingAutomationPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlMessagingPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlProcessingPoolsPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlCollectionUser", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlCollectionPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlReferenceDataPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlProcessingEnginePassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlReportingPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlExmMasterPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlFormsPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlMasterPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlWebPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("SqlProcessingTasksPassword", $PSSIM.Context.Sitecore.DatabasesPassword)
                $parameters.Add("EXMCryptographicKey", $PSSIM.Context.Sitecore.Roles.Dds.EXMCryptographicKey)
                $parameters.Add("EXMAuthenticationKey", $PSSIM.Context.Sitecore.Roles.Dds.EXMAuthenticationKey)
                $parameters.Add("SolrUrl", $PSSIM.Context.Solr.Url)
                $parameters.Add("SolrRoot", $PSSIM.Context.Solr.Folder)
                $parameters.Add("SolrService", $PSSIM.Context.Solr.Service)
                $parameters.Add("XConnectCollectionService", $PSSIM.Context.Sitecore.Roles.XcCollect.Url)
                $parameters.Add("XConnectCollectionSearchService", $PSSIM.Context.Sitecore.Roles.XcSearch.Url)
                $parameters.Add("XConnectReferenceDataService", $PSSIM.Context.Sitecore.Roles.XcRefdata.Url)
                $parameters.Add("MarketingAutomationOperationsService", $PSSIM.Context.Sitecore.Roles.MaOps.Url)
                $parameters.Add("MarketingAutomationReportingService", $PSSIM.Context.Sitecore.Roles.MaRep.Url)
                $parameters.Add("AllowedCorsOrigins", $PSSIM.Context.Sitecore.Roles.CM.Url)
                $parameters.Add("ClientSecret", $PSSIM.Context.Sitecore.Roles.Identity.ClientSecret)
                $parameters.Add("SitecoreIdentityAuthority", $PSSIM.Context.Sitecore.Roles.Identity.Url)
                $parameters.Add("DownloadLocations", ".\filethatdoesnotexist.json")
                $parameters.Add("DisableHttpsForCD", $false)
                $parameters.Add("DeployToElasticPoolName", "")
                $parameters.Add("Update", $PSSIM.Context.Settings.Update)
                # $Parameters.Add("IdentityServerCertificates_CertPath", $PSSIM.Context.Certificates.Folder)
                # $Parameters.Add("IdentityServerCertificates_RootCertFileName", $PSSIM.Context.Certificates.RootCertificate)
                # $Parameters.Add("IdentityServerCertificates_ExportPassword", $PSSIM.Context.Certificates.Password)
            }
        }

        $logFileNameString = $PSSIM.Context.Sitecore.Prefix + "_" + "SitecorePlatform" + "_" + $PSSIM.Context.Sitecore.Topology + "_" + $PSSIM.Context.Sitecore.Version

        if ( $PSSIM.Context.Settings.Uninstall ) {
            PSSIM.Sitecore.UnInstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Platform"
        }
        else {
            PSSIM.Sitecore.InstallConfiguration -Parameters $parameters -VerboseOutput $false -LogFileNameAddition $logFileNameString -SIFFolder "Platform"
        }
    }
}
