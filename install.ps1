<#
.SYNOPSIS
    Installs the provided fonts.
.DESCRIPTION
    Installs all the provided fonts by default.  The FontName
    parameter can be used to pick a subset of fonts to install.
.EXAMPLE
    C:\PS> ./install.ps1
    Installs all the fonts located in the Git repository.
.EXAMPLE
    C:\PS> ./install.ps1 furamono-, hack-*
    Installs all the FuraMono and Hack fonts.
.EXAMPLE
    C:\PS> ./install.ps1 d* -WhatIf
    Shows which fonts would be installed without actually installing the fonts.
    Remove the "-WhatIf" to install the fonts.
#>
[CmdletBinding(SupportsShouldProcess)]
param(
    # Specifies the font name to install.  Default value will install all fonts.
    [Parameter(Position=0)]
    [string[]]
    $FontName = '*'
)

$fontFiles = New-Object 'System.Collections.Generic.List[System.IO.FileInfo]'
foreach ($aFontName in $FontName) {
    Get-ChildItem $PSScriptRoot -Filter "${aFontName}.ttf" -Recurse | Foreach-Object {$fontFiles.Add($_)}
    Get-ChildItem $PSScriptRoot -Filter "${aFontName}.otf" -Recurse | Foreach-Object {$fontFiles.Add($_)}
}

$installDir = "./installPlease"
$installDirItem = New-Item $installDir -ItemType Directory -Force

foreach ($fontFile in $fontFiles) {
    Copy-Item -Force -Path $fontFile.FullName -Destination $installDir -Container
}

if ($PSCmdlet.ShouldProcess($fontFiles, "Install fonts")) {
  $shellApp = New-Object -ComObject shell.application
  $installingFonts = $shellApp.NameSpace("$($installDirItem.FullName)")
  $fonts = $shellApp.NameSpace(0x14)
  $fonts.CopyHere($installingFonts.Items())
}
if (Test-Path "$installDir") {
  Remove-Item $installDir -Recurse -Force
}
