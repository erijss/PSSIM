# PSSIM
# Copyright (c) 2022 Erwin Rijss
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.


#Requires -Version 5.0
#Requires -RunAsAdministrator

#Module folder
$PSSIMModulePath = Split-Path $MyInvocation.MyCommand.Path

# Dot source public/private functions
$private = Get-ChildItem -Path (Join-Path $PSSIMModulePath Private) -Include *.ps1 -File -Recurse -ErrorAction Stop
$public = Get-ChildItem -Path (Join-Path $PSSIMModulePath Public) -Include *.ps1 -File -Recurse -ErrorAction Stop

($private + $public) | ForEach-Object {
    try {
        . $_.FullName
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}

# manifest and version
$PSSIMManifestPath = Join-Path $PSSIMModulePath "PSSIM.psd1"
$PSSIMManifest = Test-ModuleManifest -Path $PSSIMManifestPath -WarningAction SilentlyContinue

# PSSIMContext
$script:PSSIM = @{}

$PSSIM.Info = @{
    Version              = $PSSIMManifest.Version.ToString()
    Created              = 2022
    ShowLogo             = 1
    ModulePath           = $PSSIMModulePath
}

# holds the loaded configuration
$PSSIM.Configuration = @{}

# constants used in code
$PSSIM.Constants = @{
}

# Holds the context of the loaded menu
$PSSIM.Context = @{}

$PSSIM.Context.Settings = @{
    WorkingDirectory    = $PWD
    NoLogo              = $false
    Update              = $false
    Uninstall           = $false
}

$PSSIM.Context.File = @{}
$PSSIM.Context.Sitecore = @{}
$PSSIM.Context.SqlServer = @{}
$PSSIM.Context.Solr = @{}
$PSSIM.Context.Resources = @{}
$PSSIM.Context.Certificates = @{}
# $PSSIM.Context.Redis = @{}

Export-ModuleMember -function Invoke-PSSIM
Export-ModuleMember -function Install-FromPSSIMParameters
Export-ModuleMember -function Get-PSSIMParametersFile
Export-ModuleMember -function Get-PSSIMParameters
Export-ModuleMember -function Set-PSSIMParameters
