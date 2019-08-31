write-host 'starting setup script..'

# platform wasn't added to the version table until 
# pwsh 6 (the cross platform version), so if it's
# null it means we're running pwsh 5 on windows
if ('Win32NT', $nul -contains $psversiontable.platform) {
    set-executionpolicy RemoteSigned -scope CurrentUser

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
install-module posh-git -scope currentuser -force
install-module ZLocation -scope currentuser -force

write-host 'symlinking profile..'
ln -s ./Microsoft.PowerShell_profile.ps1 $profile 

write-host 'done'
