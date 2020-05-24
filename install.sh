#!/bin/sh
VIM_PLUGINS_DIR=~/.vim/plugged
VIM_PLUG_FILE=~/.vim/autoload/plug.vim

# Clean plugins if found
if [ -d "${VIM_PLUGINS_DIR}" ]; then
    echo "Removing installed vim plugins..."
    rm -r "${VIM_PLUGINS_DIR}"
fi

# Install vim-plug if required
if [ ! -f "${VIM_PLUG_FILE}" ]; then
    echo "Installing vim-plug..."
    # Install vim-plug
    curl -fLo "${VIM_PLUG_FILE}" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Copy files
./update.sh

# Run PlugInstall then quit
echo "Installing vim plugins..."
vim +PlugInstall +qall

echo "Done!"
