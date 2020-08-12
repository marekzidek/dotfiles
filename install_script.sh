#!/bin/bash

# Create custom user with sudo priviledges
	#useradd marekzide
	#usermod -aG sudo marekzidek

# For retarded images with no manual pages
	# vim /etc/dpkg/dpkg.cfg.d/excludes
	# comment the line with: path-exclude=/usr/share/man/*
	# sudo apt-get --reinstall install man-db coreutils
	# continue with your life

# Manual installs
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#iterm
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Manual settings
Use iterm2 and set colorscheme as Elemental, and set
the foreground color to normal white instead of grey

# From system repo
man
neovim
fzf
python3-pip
tldr
zsh
tmux
ranger
bat
ripgrep
autojump
libtool
autoconf
automake


# Configs
chsh -s $(which zsh)


# Pypi
virtualenv
matplotlib
scikitlearn
numpy
pandas
torch


###### MacOS Section ########
hammerspoon
homebrew
karabiner

