#!/bin/bash

# Create custom user with sudo priviledges
	#useradd marekzidek
	#usermod -aG sudo marekzidek

# For retarded images with no manual pages
	# vim /etc/dpkg/dpkg.cfg.d/excludes
	# comment the line with: path-exclude=/usr/share/man/*
	# sudo apt-get --reinstall install man-db coreutils
	# continue with your life

# Manual installs
# OUTDATED, BUT... git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# Two coc-vim plugin related manual installs
curl -sL install-node.now.sh/lts | bash

npm install -g yarn


# ripgrep on really old ubuntu images
if $(uname -a) | grep "ubuntu"; then
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
	sudo dpkg -i ripgrep_11.0.2_amd64.deb
fi

#fzf
git clone git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#kube_sync
git clone https://github.com/nraw/kube_sync.git ~/.bin/kube-sync
cp ~/.bin/kube-sync/kube_sync.sh ~/.bin/ks

#v
git clone https://github.com/rupa/v.git ~/.bin
git clone https://github.com/andrewferrier/fzf-z ~/.bin


# Tmux plugins
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
then `tmux source ~/.tmux.conf`
and then most importantly: `prefix + I` to install the listed plugins!


# If using big sur 11.0 and newer, pyenv will be a terrible experience 
Solve using this link https://github.com/pyenv/pyenv/issues/1737

# Manual settings
Install iterm2
Use iterm2 and set colorscheme as Elemental, and set
the foreground color to normal white instead of grey


For ctrl-tabbing in tmux
 Go to profiles -> Keys -> Key Mappings and add:
 	Send Hex Codes: 0x01 0x6e for ^Tab -> 
	Send Hex Codes: 0x01 0x7d for ^Shift+Tab <-



# From system repo

ctags
man
zlib
bzip2
neovim
fzf
python3-pip
tldr
ctags-exuberant
virtualenv
htop
zsh
tmux
ranger
bat
ripgrep
tokei
autojump
libtool
autoconf
automake
pyenv
pyenv-virtualenv


# Change default shell
chsh -s $(which zsh)

# Install vim plugins
vim +PluginInstall +qall
#vim +"CocInstall coc-json coc-python coc-snippets"

# Pypi
virtualenv
pyyaml
loguru
ipython
matplotlib
scikitlearn
numpy
pandas
torch
fire
black
isort
jedi
neovim-remote
poetry


Make sure to run CocConfig and copy the contents of coc-settings.json to the one from CocConfig

###### MacOS Section ########
brew:
  hammerspoon
  homebrew
  karabiner
  ical-buddy

  One has to open icalendar:
  	and do Calendar -> Add Acount -> Microsoft Exchange
	Then, it is nice to disable notifications from one of the calendars, do it by going to generic Apple menu > System Settings, then click Notifications in the sidebar

		Sometimes the calendar stops syncing:
		25/30 * * * * pkill -f CalendarAgent into crontab to make it sync all the time

		If one wants to not open god damn chrome tab with zoom and not actually needed for anything, then:
			check finicky.js in Andrejs personal github dotfiles, and install finicky


 brew, ALWAYS PIN superimportant packagesL
 	brew pin vim
	brew pin ruby
 	brew pin perl



cask:
  altTab

Settings in atltab:
 Blacklists:
	 com.McAfre.McAfeeSafariHost (hide in AltTab - Always)
	 com.googlecode.iterm2 (hide in AltTab - Always)
	 com.tinyspeck.slackmacgap (hide in AltTab - Always)
	 com.microsoft.Outlook (hide in AltTab - Always)

 And then shortcut 1 on is with minimized windows -> Hide
 and shortcut 2 is (option tab) is with minimized windows -> Show

