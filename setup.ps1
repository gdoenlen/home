Write-Host 'starting setup script..'

# platform wasn't added to the version table until 
# pwsh 6 (the cross platform version), so if it's
# null it means we're running pwsh 5 on windows
if ('Win32NT', $null -contains $psversiontable.platform) {
    Set-ExecutionPolicy RemoteSigned -scope CurrentUser

    Write-Host 'installing scoop..'
    Invoke-Expression (New-Object net.webclient).downloadstring('https://get.scoop.sh')
    scoop bucket add extras
    scoop bucket add java
    scoop bucket add nonportable

    scoop update

    Write-Host 'installing programs..'
    scoop install vscode postman 7zip kdiff3 autohotkey `
    adopt8-hotspot apache-ivy git maven nodejs-lts pgadmin4-np `
    postgresql psutils python sbt tldr jmc gradle

    Write-Host 'copying terminal settings..'
    $packages = "$(Split-Path $env:APPDATA)/local/packages"
    Get-ChildItem $packages | Select-Object -ExpandProperty Name | Where-Object { 
        $_ -match 'Microsoft.WindowsTerminal'
    } | ForEach-Object {
        Copy-Item ./profiles.json "$packages/$_/localstate/profiles.json"
    }
} else {
    apt update
    # todo
}

Write-Host 'installing ps modules..'
Install-Module posh-git -scope currentuser -force
Install-Module ZLocation -scope currentuser -force

Write-Host 'copying profile..'
Copy-Item ./Microsoft.PowerShell_profile.ps1 $profile 
Copy-Item ./.vimrc ~

Write-Host 'done'
