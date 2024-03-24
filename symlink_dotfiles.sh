ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf
ln -s $(pwd)/.finicky.js ~/.finicky.js

# Just don't use neovim... it's shit, remember that, forever
mkdir -p ~/.config/nvim
ln -s $(pwd)/nvim/init.vim ~/.config/nvim/init.vim
mkdir -p ~/.ipython/profile_default/startup
ln -s $(pwd)/ipython/profile_default/startup/keybindings.py ~/.ipython/profile_default/startup/keybindings.py
ln -s $(pwd)/ipython/profile_default/startup/start.ipy ~/.ipython/profile_default/startup/start.ipy
mkdir -p ~/.config/lf
ln -s $(pwd)/lf/lfrc ~/.config/lf/lfrc

mkdir -p ~/.vim
ln -s $(pwd)/.vim/coc-settings.json ~/.vim/coc-settings.json

mkdir -p ~/config
ln -s $(pwd)/flake8 ~/.config/flake8

ln -s ~/dotfiles/init.lua ~/.hammerspoon/init.lua
