# PSSIF
# Copyright (c) 2021 Erwin Rijss
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

#Module folder
$PSSIFModulePath = Split-Path $MyInvocation.MyCommand.Path

# Dot source public/private functions
$private = Get-ChildItem -Path (Join-Path $PSSIFModulePath Private) -Include *.ps1 -File -Recurse -ErrorAction Stop
$public = Get-ChildItem -Path (Join-Path $PSSIFModulePath Public) -Include *.ps1 -File -Recurse -ErrorAction Stop

($private + $public) | ForEach-Object {
    try {
        . $_.FullName
    }
    catch {
        Write-Warning $_.Exception.Message
    }
}

# manifest and version
$PSSIFManifestPath = Join-Path $PSSIFModulePath "PSSIF.psd1"
$PSSIFManifest = Test-ModuleManifest -Path $PSSIFManifestPath -WarningAction SilentlyContinue

# PSSIFContext
$script:PSSIF = @{}

$PSSIF.Info = @{
    Version              = $PSSIFManifest.Version.ToString()
    Created              = 2022
    ShowLogo             = 2
    ModulePath           = $PSSIFModulePath
}

# holds the loaded configuration
$PSSIF.Configuration = @{}

# constants used in code
$PSSIF.Constants = @{
}

# Holds the context of the loaded menu
$PSSIF.Context = @{}

$PSSIF.Context.Settings = @{
    NoLogo       = $false
}
$PSSIF.Context.Menus = @{}
$PSSIF.Context.Actions = @{}
$PSSIF.Context.Texts = @{}
$PSSIF.Context.Repositories = @{}
$PSSIF.Context.Modules = @{}
$PSSIF.Context.Scripts = @{}

Export-ModuleMember -function Invoke-PSSIF
