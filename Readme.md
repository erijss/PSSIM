# PowerShell Sitecore Install Module

PowerShell Sitecore Install Module (PSSIM) is a wrapper around the Sitecore Installation Framework (SIF) module. From a single parameters file, you can install every Sitecore version since Sitecore 9.3 in differnet topologies (XM0, XM1, XP0, XP1) or install  additional modules like SXA, SPE, Headless Services, Connect Framework and more. This module is only intended to install Sitecore Experience Platform for local development and should never used for production environments.

PSSIM has combined all the SIF json file from Sitecore 9.3 and beyond. Earlier versions are not supported by this module. The SIF json files are adapted to be used in PSSIM, although the order of tasks is not changed.

>**Note**
Despite the intro, not all versions are implemented yet. WIP :-)


## PSSIM Development status
The table below gives an overview of the implemented topologies modules that can be installed right in the currently published version (1.01)

||930|1000|1001|1002|1003|1010|1011|1012|1020|
|-|-|-|-|-|-|-|-|-|-|
|Prerequisites|X|X|X|X|X|X|X|X|X|
|Solr|X|X|X|X|X|X|X|X|X|
|XM0|-|-|-|-|-|-|-|-|X|
|XM1|-|-|-|-|-|-|-|-|X|
|XP0|-|-|-|-|-|-|-|-|X|
|XP1|-|-|-|-|-|-|-|-|X|
|SPE|-|-|-|-|-|-|-|-|X|
|SHH|-|-|-|-|-|-|-|-|X|
|SXA|-|-|-|-|-|-|-|-|X|
|PS|-|-|-|-|-|-|-|-|-|
|Connect Framework (DEF)|-|-|-|-|-|-|-|-|-|
|Connect Tenant|-|-|-|-|-|-|-|-|-|
|Connect CH|-|-|-|-|-|-|-|-|-|
|Connect DAM|-|-|-|-|-|-|-|-|-|
|Connect CMP|-|-|-|-|-|-|-|-|-|
|Connect Dynamics|-|-|-|-|-|-|-|-|-|
|Connect Salesforce|-|-|-|-|-|-|-|-|-|
|Custom Cores|-|-|-|-|-|-|-|-|X|
|Custom Bindings|-|-|-|-|-|-|-|-|-|

## Get the PowerShell module
The module is in the PowerShell Gallery (https://www.powershellgallery.com/). To install the module:

```
Install-Module PSSIM
```

## PSSIM Functions
- Get-PSSIMParametersFile
  This function gives you a clean parameters file
  ```
  Get-PSSIMParametersFile
  ```
- Get-PSSIMParameters
  This function shows the interal parameters, based on a parametersfile
  ```
  Get-PSSIMParameters -Path PSSIM-Parameters.json
  ```
- Install-FromPSSIMParameters
  This function installs or uninstalls Sitecore or a module based on the given action
  ```
  Install-FromPSSIMParameters -Path PSSIM-Parameters.json -Action SitecorePlatform
  ```

  Use without Action parameter to get a list of all actions:
  ```
  Install-FromPSSIMParameters -Path PSSIM-Parameters.json
  ```

  Use with the Uninstall parameter to uninstall
  ```
  Install-FromPSSIMParameters -Path PSSIM-Parameters.json -Action SitecorePlatform -Uninstall
  ```

These functions are also part of the module, but highly experimental right now:
- Invoke-PSSIM
  Shows a menu based on the PowerShell JsonMenu module (https://www.github.com/erijss/JsonMenu)
  ```
  Invoke-PSSIM
  ```
- Set-PSSIMParameters
  Not yet used, although the module can hold the parameters from a previous session
  ```
  Set-PSSIMParameters -Path PSSIM-Parameters.json
  ```

## Structuring you packages
All the Sitecore packages and Sitecore Web Deploy packages (scwdp) are NOT a part of this module. You have to download them yourself and store them in a structured way. The convention is:
- [Your Resource Folder]
  - 930
  - 1000
  - 1001
  - ...
  - 1020

The names of the folder are based on the Sitecore version without dots. Sitecore 9.3 is the 930 folder, Sitecore 10.1 - Update 1 is the 1011 folder.

The PSSIM-Parameters.json file that can get from the module, contains the list of the names of all packages. A small extract:

```
            ....
            "SXA_XM_CD": {
                "name": "Sitecore Experience Accelerator XM 10.0.0.3138 CD.scwdp.zip"
            },
            "SXA_XM_CM": {
                "name": "Sitecore Experience Accelerator XM 10.0.0.3138.scwdp.zip"
            },
            "SXA_XP_CD": {
                "name": "Sitecore Experience Accelerator 10.0.0.3138 CD.scwdp.zip"
            },
            "SXA_XP_CM": {
                "name": "Sitecore Experience Accelerator 10.0.0.3138.scwdp.zip"
            }
        },
        "1010": {
            "CONNECT_FRAMEWORK": {
                "name": "Data Exchange Framework 6.0.0 rev. 01537.zip"
            },
            "CONNECT_FRAMEWORK_TENANT_SERVICE_HOST": {
                "name": "Sitecore Data Exchange Framework Tenant Web Service 6.0.0 rev. 01537.scwdp.zip"
            },
            "CONNECT_FRAMEWORK_TENANT_SERVICE_CM": {
                "name": "n.a."
            },
            ....
```

To obtain the packages you have to download them from the Sitecore Developers site (https://dev.sitecore.com). If you want to install

## The PSSSIM Parameters File
To get the PSSIM Parameters File you can use the method

  ```
  Get-PSSIMParametersFile
  ```

By default you get a documented version of the PSSIM parameters file. If you want to have an undocumented version use:

  ```
  Get-PSSIMParametersFile -Undocumented
  ```

The PSSIM parameters file is a Json file to set all the parameters for an installation and uninstall(!). By keeping the parameters file, you can easily repeat the same installation or add modules on the same installation. Best practice is to store each file in a folder and run the PSSIM module from that folder. All the (un)installation logfiles are stored in that folder too.

The PSSIM parameters file has these sections:
- Resources
- Sitecore
- SqlServer
- Solr
- Redis
- Certificates
- Packages

Within each section there are the parameters you can set. The documented version of the PSSIM parameters file explain them all.

>**Note**
Not all parameters are used yet. For example, the Redis and Certificates section are not implemented yet and the downloadlocations parameter has also not a function yet.


## Solr installation
The PSSIM module has a strict way how Solr is installed. A Solr installation can be done from the module as well **and is mandatory to use this module**. If Solr is installed with these parameters in the MyProject.json parameter file:

```
    "solr": {
        "folder": "D:\\Data\\Solr",
        "version": "8.8.2",
        "prefix": "my-",
        "portprefix": 9,
        "cores": [
            "project_website_master_index",
            "project_website_web_index"
        ]
    },
```

Using this command:
```
Install-FromPSSIMParameters -Path ".\MyProject.json" -Action SolrSearchEngine
```

The outcome is:
- The Solr instance is stored in *D:\Data\Solr\my-solr-8.8.2*
- The name of the Solr service is *my-solr-8.8.2*
- Solr is running on *localhost*
- Solr is running on port *9882*

The Solr port is set based on the version number without dots and the prefix. Thus it is easy to install multiple Solr versions or multiple instanced of the same Solr version locally.

Custom cores can be added in a separate install action

## The Prefix parameter
The prefix parameters plays a central role and is used for various things:
It is used to group the sites. A Sitecore XM1 installation is installed like:
- C:\inetpub\wwwroot\DEMO\demo.auth
- C:\inetpub\wwwroot\DEMO\demo.cd
- C:\inetpub\wwwroot\DEMO\demo.cm

The prefix is by default also used for the name of the site, combined with the identifier of the different roles. Although, the parameter `hostnamepattern` can be used to define a different pattern for the Sitecore roles in your chosed topologies

All databases and Solr cores are prefixed with the Prefix as well

## The packages section in the PSSIM parameters file
In the packages section of the PSSIM parameters file, you have on overview of which packages are used for the different versions of Sitecore. In your project PSSIM parameters file you can obviously delete all version nodes that do not apply.

Sometimes you Sitecore releases a new version of a module. For example, a new version of Sitecore Headless Services might be released within the same version. You can easily update the package name in the PSSIM parameters file, to use this new pacakge.

## The packages section in the PSSIM parameters file
Once you have your PSSIM parameters file configured (and your Solr instance), you can install Sitecore and it's modules step by step, or you use a simple script to do it at once. An example such a PowerShell MyProject.ps1 script:

```
Install-FromPSSIMParameters -Path .\MyProject.json -Action SitecorePlatform
Install-FromPSSIMParameters -Path .\MyProject.json -Action SitecorePowerShellExtensions -NoLogo
Install-FromPSSIMParameters -Path .\MyProject.json -Action SitecoreHeadlessServices -NoLogo
Install-FromPSSIMParameters -Path .\MyProject.json -Action AddCustomSolrCores -NoLogo
```
