# Common config for .bashrc and .zshrc

# ---------- Aliases ----------

# Color aliases
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias diff="diff --color=auto"

# General aliases
alias ll="ls -lah"
alias la="ls -a"
alias x="exit"
alias rgrep="grep -nr"
alias lzg="lazygit"
alias lzd="lazydocker"
alias rovim="vim -MR"
alias fvim='vim $(fzf)'
alias jcurl="curl -H 'Content-Type: application/json'"
alias myip="curl checkip.amazonaws.com"
alias space="df -h -t ext4"
alias stime="/usr/bin/time -p"

# Pagers
LESS_SCRIPT="/usr/local/share/vim/vim81/macros/less.sh"
if [ -f $LESS_SCRIPT ]; then
    alias vless="$LESS_SCRIPT"
fi

# AWK one liners
alias mostused="history | awk '{usage[\$2]+=1}END{for(key in usage){print key, usage[key]}}' | sort -nrk 2 | head"
alias gitopen="firefox \$(git remote -v | awk '/origin/{print substr(\$2,0,length(\$2)-4);exit}')"
alias paths="echo \$PATH | awk -F ':' '{for (i=1;i<NF;i++){print \$i}}'"
alias temps="cat /sys/class/thermal/thermal_zone*/temp | awk '{print \"Thermal Zone \" NR-1 \" \" \$1/1000 \"C\"}'"

# Python
alias python="python3"
alias pip="pip3"
alias pr="pipenv run"
alias prp="pipenv run python"

# Docker
alias doco="docker-compose"

# Docker project specific
alias dcadmin="docker-compose exec web django-admin"
alias dcsql="docker-compose exec db psql --user postgres"

# Json
alias jview="jq -C . | less -R"

# ---------- Variables ----------

# Default editor
export EDITOR="vim"

# Default browser
export BROWSER="firefox"

# BC
export BC_ENV_ARGS="${HOME}/.bc"

# Git
export GIT_TEMPLATE_DIR=~/.git_template

# FZF
export FZF_DEFAULT_COMMAND='rg --files'

# ---------- Loading ---------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ---------- Completion ----------

AWS_COMPLETER="$HOME/.local/bin/aws_completer"
if [[ -x "$AWS_COMPLETER" ]]; then
    complete -C "$AWS_COMPLETER" aws
fi
