# Prompt
setopt promptsubst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats ' (%b)'
zstyle ':vcs_info:*' actionformats ' (%b|%a)'

precmd () { vcs_info }

PROMPT='%B%F{green}%n%f%b:%B%F{blue}%3~%f%b${vcs_info_msg_0_} $ '

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# ctrl left/right for moving by word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word

# History config
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt share_history
setopt hist_ignore_all_dups

# History search with up/down after typing
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "${terminfo[kcud1]}" down-line-or-beginning-search

# Set LS_COLORS
eval "$(dircolors -b)"

# Auto pushd
setopt auto_pushd
setopt pushd_silent

# Cap dir stack size
DIRSTACKSIZE=10

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
if [ -f $AWS_COMPLETER ]; then
    source $AWS_COMPLETER
fi

# Load fzf if available
if [ -f ~/.fzf.zsh ]; then
    export FZF_DEFAULT_COMMAND='rg --files'
    source ~/.fzf.zsh
fi

# Skip compinit in global config
skip_global_compinit=1

# Common config
source $HOME/.shellrc