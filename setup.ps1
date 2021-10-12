Write-Host 'starting setup script..'

Set-ExecutionPolicy RemoteSigned -scope CurrentUser

Write-Host 'installing scoop..'
Invoke-Expression (New-Object net.webclient).downloadstring('https://get.scoop.sh')
scoop bucket add extras
scoop bucket add java
scoop bucket add nonportable

scoop update

Write-Host 'installing programs..'
scoop install vscode 7zip kdiff3 autohotkey `
jmc git maven adoptopenjdk-hotspot`

Write-Host 'installing editor extensions..'
code --install-extension vscjava.vscode-java-pack
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension redhat.fabric8-analytics
code --install-extension eamodio.gitlens
code --install-extension SonarSource.sonarlint-vscode
code --install-extension vscodevim.vim
code --install-extension skattyadz.vscode-quick-scope

Write-Host 'copying terminal settings..'
$packages = "$(Split-Path $env:APPDATA)/local/packages"
Get-ChildItem $packages `
    | Select-Object -ExpandProperty Name `
    | Where-Object { $_ -match 'Microsoft.WindowsTerminal' } `
    | ForEach-Object { Copy-Item ./profiles.json "$packages/$_/localstate/profiles.json" }
 
Write-Host 'installing ps modules..'
Install-Module posh-git -scope currentuser -force
Install-Module ZLocation -scope currentuser -force

Write-Host 'copying profile..'
Copy-Item ./Microsoft.PowerShell_profile.ps1 $profile 
Copy-Item ./.vimrc ~
Copy-Item ./.ideavimrc ~

Write-Host 'done'
