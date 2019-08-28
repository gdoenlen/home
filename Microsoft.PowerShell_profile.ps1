if (!(get-module -listavailable -name PSReadline)) {
    install-module PSReadLine -scope currentuser -force
}
import-module PSReadline

if (!(get-module -listavailable -name posh-git)) {
    install-module posh-git -scope currentuser -force
}

import-module posh-git

# start fzf at the top
$fzf = whereis fzf
function fzf {
    invoke-expression $("$fzf --reverse")
}