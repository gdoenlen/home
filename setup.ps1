# Windows setup script

set-executionpolicy RemoteSigned -scope CurrentUser

# install scoop
write-host "installing scoop.."
invoke-expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
scoop bucket add extras
scoop bucket add java
scoop bucket add nonportable

scoop update

write-host "installing programs.."
scoop install vscode postman 7zip kdiff3 autohotkey

# check for WSL and install dev tools if its not
if (!get-command ubuntu -errorAction SilentlyContinue) {
    write-host "WSL not detected, installing dev tools.."
    scoop install adopt8-hotspot apache-ivy git gow jq maven nodejs-lts pgadmin4-np
    scoop install postgresql psutils python sbt
    install-module posh-git -Scope CurrentUser -Force
}
