$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1
$env:POWERSHELL_TELEMETRY_OPTOUT = 1

if (!(Get-Module -ListAvailable -Name posh-git)) {
    Install-Module posh-git -Scope CurrentUser -Force
}
Import-Module posh-git
$GitPromptSettings.DefaultPromptAbbreviateHomeDirectory = $true

if (!(Get-Module -ListAvailable -Name ZLocation)) {
    Install-Module ZLocation -Scope CurrentUser -Force
}
Import-Module ZLocation

if (!(Get-Module -ListAvailable -Name Microsoft.PowerShell.ConsoleGuiTools)) {
    Install-Module Microsoft.PowerShell.ConsoleGuiTools
}

if (!(Test-Path ~/code/poshdotenv)) {
    $cwd = $PWD
    Set-Location ~/code

    git clone https://github.com/gdoenlen/poshdotenv 
    Set-Location $cwd
}
Import-Module -Name ~/code/poshdotenv/module/dotenv

if ($PSVersionTable.Platform -eq 'Unix') {
    $env:TMP = [IO.Path]::GetTempPath()
}

Set-Alias -Name from-json -Value convertfrom-json
Set-Alias -Name to-json -Value convertto-json
Set-Alias -Name from-string -Value convertfrom-string
Set-Alias -Name from-csv -Value convertfrom-csv
Set-Alias -Name to-csv -Value convertto-csv
Set-Alias -Name to-xml -Value convertto-xml
Set-Alias -Name grep -Value select-string

function mkdir($path) {
    New-Item -ItemType Directory -Path $path
}

function touch($path) {
    Write-Host $null >> $path
}

function whereis($cmd) {
    Get-Command $cmd -all | Foreach-Object { Write-Output $_.path }
}

function which($cmd) {
    $(Get-Command $cmd).path
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
Set-PSReadLineOption -ShowToolTips
Set-PSReadLineOption -PredictionSource History

# make sure we start in the home directory
Set-Location ~
