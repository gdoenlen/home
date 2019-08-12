#!/usr/bin/env bash

# New computer set up script

apt update
apt upgrade -y
apt install -y zsh

# setup oh-my-zsh, i know bad
bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# the code directory and dotfiles folder should already exist
# as that is where this script lives
ln -s ~/code/dotfiles/.zshrc ~/.zshrc
ln -s ~/code/dotfiles/theme.zsh-theme ~/.oh-my-zsh/custom/themes/theme.zsh-theme

# finally change shell to zsh
chsh -s $(command -v zsh)
zsh
