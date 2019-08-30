#!/usr/bin/env bash

# New computer set up script
set -euo pipefail
IFS=$'\n\t'

apt update
apt upgrade -y

# https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6
wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb
apt update
add-apt-repository universe
apt install powershell -y

pwsh ./setup.ps1

# finally change shell to pwsh
chsh -s $(command -v pwsh)
pwsh
