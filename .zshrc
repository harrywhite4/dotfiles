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

# AWS completion
AWS_COMPLETER="$HOME/.local/bin/aws_zsh_completer.sh"
if [[ -f $AWS_COMPLETER ]]; then
    source $AWS_COMPLETER
fi

# Common config
source $HOME/.shellrc
