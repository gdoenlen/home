if (!(get-module -listavailable -name posh-git)) {
    install-module posh-git -scope currentuser -force
}

if (!(get-module -listavailable -name ZLocation)) {
    install-module ZLocation -scope CurrentUser -force
}

import-module posh-git
import-module ZLocation

set-alias -name from-json -value ConvertFrom-Json
set-alias -name to-json -value ConvertTo-Json
set-alias -name from-string -value ConvertFrom-String
set-alias -name from-csv -value ConvertFrom-Csv
set-alias -name to-csv -value ConvertTo-Csv
set-alias -name to-xml -value ConvertTo-Xml
set-alias -name grep -value Select-String

# start fzf at the top
$fzf = whereis fzf
function fzf {
    invoke-expression $("$fzf --reverse")
}

function mkdir($path) {
    new-item -itemtype directory -path $path
}

function touch($path) {
    write-host $nul >> $path
}

function whereis($cmd) {
    get-command $cmd
}
