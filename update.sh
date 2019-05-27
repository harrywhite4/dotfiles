#!/bin/sh
DOTFILES=$(find -name '.*' -type f)
echo "Copying\n$DOTFILES"
cp --backup $DOTFILES ~
echo "Copying git template"
cp --backup -r ./.git_template ~
echo "Done!"
exit 0
