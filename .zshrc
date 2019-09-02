# Path to your oh-my-zsh installation.
export ZSH="/home/harry/.oh-my-zsh"

# Theme to load
ZSH_THEME=""

# Oh my zsh plugins
plugins=()

# Load oh my zsh
source $ZSH/oh-my-zsh.sh

# Prompt
PS1="%B%F{green}%n%f%b:%B%F{blue}%3~%f%b$ "

# Common config
source $HOME/.shellrc
