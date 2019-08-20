#!/usr/bin/env bash

# New computer set up script
set -euo pipefail
IFS=$'\n\t'

apt update
apt upgrade -y
apt install -y zsh

# setup oh-my-zsh, i know bad
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# the code directory and dotfiles folder should already exist
# as that is where this script lives
ln -s ~/code/dotfiles/.zshrc ~/.zshrc
ln -s ~/code/dotfiles/theme.zsh-theme ~/.oh-my-zsh/custom/themes/theme.zsh-theme

# check if we're running WSL and setup our windows environment
if [[ $(uname -r | cut -d '-' -f 3) == "Microsoft" ]]; then
    echo WSL Detected running powershell setup script..
    powershell.exe setup.ps1
fi

# finally change shell to zsh
chsh -s $(command -v zsh)
zsh
