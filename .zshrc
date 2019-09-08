# Prompt
PS1="%B%F{green}%n%f%b:%B%F{blue}%3~%f%b$ "

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# History config
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt share_history
setopt hist_ignore_all_dups

# History search with up/down after typing
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "${key[Up]}" up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${key[Down]}" down-line-or-beginning-search

# Set LS_COLORS
eval "$(dircolors -b)"

# Auto pushd
setopt auto_pushd
setopt pushd_silent

# Use modern completion system
setopt auto_menu
setopt always_to_end

autoload -Uz compinit
compinit

zmodload -i zsh/complist

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Complete menu binding
bindkey -M menuselect '^o' accept-and-infer-next-history

# AWS completion
AWS_COMPLETER="$HOME/.local/bin/aws_zsh_completer.sh"
if [[ -f $AWS_COMPLETER ]]; then
    source $AWS_COMPLETER
fi

# Common config
source $HOME/.shellrc
