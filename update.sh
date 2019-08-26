#!/bin/bash
set -e

OPTIONS="--help show help and exit\n--verbose print aditional info"
USAGE="$0 [options]\nOptions:\n${OPTIONS}"
VERBOSE=0

# Flag arg parsing
for i in $@; do
    case $i in
        "--help")
            echo -e "$USAGE"
            exit 0
            ;;
        "--verbose")
            VERBOSE=1
            ;;
    esac
done

# Go to top of git repo
TOP="$(git rev-parse --show-toplevel)"
cd $TOP

echo "Copying dotfiles..."

# Merge gitconfig with gitname if avaliable
mv ~/.gitconfig ~/.gitconfig~
if [[ -f ~/.gitname ]]; then
    cat ~/.gitname .gitconfig > ~/.gitconfig
else
    cp ./.gitconfig ~/.gitconfig
fi

if [[ $VERBOSE -eq 1 ]]; then
    echo "Copied ./.gitconfig"
fi

# Copy dotfiles
DOTFILES="$(find . -maxdepth 1 -type f -regex '\./\..*' -a -not -name '.gitconfig')"
for DF in $DOTFILES; do
    cp --backup $DF $HOME
    if [[ $VERBOSE -eq 1 ]]; then
        echo "Copied $DF"
    fi
done

echo "Copying dotdirs..."

# Copy dot dirs
DOTDIRS="$(find . -maxdepth 1 -type d -regex '\./\..*' -a -not -name '.git')"
for DD in $DOTDIRS; do
    cp --recursive $DD $HOME
    if [[ $VERBOSE -eq 1 ]]; then
        echo "Copied $DD"
    fi
done

echo "Done!"
exit 0
