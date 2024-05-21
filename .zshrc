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

# History config
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt share_history
setopt hist_ignore_all_dups

# History search with up/down after typing
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
if [[ "$terminfo[kcuu1]" && "$OSTYPE" != darwin* ]]; then
    bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
else
    bindkey "^[[A" up-line-or-beginning-search
fi

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
if [[ "$terminfo[kcud1]" && "$OSTYPE" != darwin* ]]; then
    bindkey "$terminfo[kcud1]" up-line-or-beginning-search
else
    bindkey "^[[B" down-line-or-beginning-search
fi

# Set LS_COLORS
if [[ "$(command -v dircolors)" ]]; then
    eval "$(dircolors -b)"
fi

# Auto pushd
setopt auto_pushd
setopt pushd_silent

# Cap dir stack size
DIRSTACKSIZE=10

# Set time format
TIMEFMT=$'\n================\nCPU\t%P\nuser\t%*Us\nsystem\t%*Ss\ntotal\t%*Es'

# Use modern completion system
setopt auto_menu
setopt always_to_end

# Load zsh completion
autoload -Uz compinit
compinit

# Load bash completion
autoload -Uz bashcompinit
bashcompinit

zmodload -i zsh/complist

# Taken from /etc/zsh/newuser.zsh.recommended
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

# Disable flow control (ctrl-s ctrl-q)
stty -ixon

# Load fzf if available
if [[ -f ~/.fzf.zsh ]]; then
    source ~/.fzf.zsh
elif [[ -f /usr/share/zsh/vendor-completions/_fzf ]]; then
    source /usr/share/zsh/vendor-completions/_fzf
fi

# Skip compinit in global config
skip_global_compinit=1

# Zcalc
autoload zcalc
alias calc="zcalc -f"

# Better history command
alias allhistory="fc -l -i 0"

# Common config
source $HOME/.common.sh
