write-host 'starting setup script..'
if ($psversiontable.platform -eq 'Win32NT') {
    set-executionpolicy RemoteSigned -scope CurrentUser

    # install scoop
    write-host 'installing scoop..'
    invoke-expression (new-object net.webclient).downloadstring('https://get.scoop.sh')
    scoop bucket add extras
    scoop bucket add java
    scoop bucket add nonportable

    scoop update

    write-host 'installing programs..'
    scoop install vscode postman 7zip kdiff3 autohotkey
    scoop install adopt8-hotspot apache-ivy git gow jq maven nodejs-lts pgadmin4-np
    scoop install postgresql psutils python sbt
} else {
    apt update
    # todo
}

write-host 'installing ps modules..'
install-module posh-git -scope CurrentUser -force
install-module ZLocation -scope CurrentUser -force

write-host 'symlinking profile..'
ln -s ./Microsoft.PowerShell_profile.ps1 $profile 

write-host 'done'
