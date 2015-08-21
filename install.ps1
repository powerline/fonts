$sa = new-object -comobject shell.application
$fonts =  $sa.NameSpace(0x14)
gci $PSScriptRoot -i *.ttf, *.otf -Recurse | %{$fonts.CopyHere($_.FullName)}
