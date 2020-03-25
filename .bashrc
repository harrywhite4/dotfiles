# don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# History size
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Allow ** expansion
shopt -s globstar

# Load bash completion files if posix off
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Load fzf if avaliable set default command
if [ -f ~/.fzf.bash ]; then
    export FZF_DEFAULT_COMMAND='rg --files'
    source ~/.fzf.bash
fi

# Prompt
export PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\] \$ "

# include common files
source $HOME/.common.sh
