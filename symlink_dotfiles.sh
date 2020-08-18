ln -s $(pwd)/.zshrc ~/.zshrc
ln -s $(pwd)/.vimrc ~/.vimrc
ln -s $(pwd)/.tmux.conf ~/.tmux.conf

# Just don't use neovim... it's shit, remember that forever
#mkdir -p ~/.config/nvim
#ln -s $(pwd)/nvim/init.vim ~/.config/nvim/init.vim
ln -s $(pwd)/ipython/profile_default/startup/keybindings.py ~/.ipython/profile_default/startup/keybindings.py
