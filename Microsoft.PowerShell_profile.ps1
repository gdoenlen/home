if (!(get-module -listavailable -name posh-git)) {
    install-module posh-git -scope currentuser -force
}

if (!(get-module -listavailable -name ZLocation)) {
    install-module ZLocation -scope currentuser -force
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
    $(get-command $cmd).path
}

# start fzf at the top
$fzf = whereis fzf
function fzf {
    invoke-expression $("$fzf --reverse")
}
