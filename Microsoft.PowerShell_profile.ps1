if (!(get-module -listavailable -name posh-git)) {
    install-module posh-git -scope currentuser -force
}

if (!(get-module -listavailable -name ZLocation)) {
    install-module ZLocation -scope CurrentUser -force
}

import-module posh-git
import-module ZLocation

# start fzf at the top
$fzf = whereis fzf
function fzf {
    invoke-expression $("$fzf --reverse")
}
