$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1
$env:POWERSHELL_TELEMETRY_OPTOUT = 1

if (!(get-module -listavailable -name posh-git)) {
    install-module posh-git -scope currentuser -force
}

if (!(get-module -listavailable -name ZLocation)) {
    install-module ZLocation -scope currentuser -force
}

if (!(Get-Module -ListAvailable -Name Microsoft.PowerShell.ConsoleGuiTools)) {
    Install-Module Microsoft.PowerShell.ConsoleGuiTools
}

if ($PSVersionTable.Platform -eq 'Unix') {
    $env:TMP = [IO.Path]::GetTempPath()
}

# modules 

# posh-git
import-module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

# ZLocation
import-module ZLocation

# aliases
set-alias -name from-json -value convertfrom-json
set-alias -name to-json -value convertto-json
set-alias -name from-string -value convertfrom-string
set-alias -name from-csv -value convertfrom-csv
set-alias -name to-csv -value convertto-csv
set-alias -name to-xml -value convertto-xml
set-alias -name grep -value select-string

function mkdir($path) {
    new-item -itemtype directory -path $path
}

function touch($path) {
    write-host $null >> $path
}

function whereis($cmd) {
    get-command $cmd -all | foreach-object { write-output $_.path }
}

function which($cmd) {
    $(get-command $cmd).path
}

function format-pretty([parameter(ValueFromPipeline)] $json, $depth = 100) {
    $json | from-json | to-json -depth $depth
}

# cat(1) with line numbers
function lat([parameter(ValueFromPipeline, Position = 0)] $path) {
    $i = 0
    Get-Content @PSBoundParameters | ForEach-Object {
        $i++
        $lineNum = if ($i -lt 10) {
            '0' + $i.ToString()
        } else {
            $i.ToString()
        }
        $lineNum + ' ' + $_
    }
}

# sudo isn't currently supported for cmdlets
# see: https://github.com/PowerShell/PowerShell/issues/11343
function pssudo {
    & /usr/bin/env sudo pwsh -NoProfile -NonInteractive -Command "& $args"
}

# conhost on windows messes up the colors
Set-PSReadLineOption -colors @{Command = '#FFFF00'}
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# make sure we start in the home directory
Set-Location ~
