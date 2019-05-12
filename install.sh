#!/bin/sh
VUNDLE_DIR=~/.vim/bundle/Vundle.vim
# Install vundle if directory not found
if [ ! -d $VUNDLE_DIR ]; then
    git clone https://github.com/VundleVim/Vundle.vim.git $VUNDLE_DIR
fi
# Copy vimrc
cp --backup vimrc ~/.vimrc
# Run PluginInstall then quit
vim +PluginInstall +qall
