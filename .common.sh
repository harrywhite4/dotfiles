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
alias rgrep="grep -n -r"
alias rovim="vim -MR"
alias fvim='vim $(fzf)'
alias jcurl="curl -H 'Content-Type: application/json'"
alias myip="curl checkip.amazonaws.com"
alias space="df -h -t ext4"
alias howbig="du -sh"
alias stime="/usr/bin/time -p"

# Pagers
LESS_SCRIPT="/usr/local/share/vim/vim82/macros/less.sh"
if [ -f "$LESS_SCRIPT" ]; then
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
alias jview="view -c 'set ft=json' -"

# fd alias if installed as fdfind
if [ "$(command -v fdfind)" ] && [ -z "$(command -v fd)" ]; then
    alias fd="fdfind"
fi

# Clipboard alias
if [ "$(command -v xsel)" ]; then
    alias clip="xsel -b"
fi

# ---------- Variables ----------

# Default editor
export EDITOR="vim"

# Default browser
export BROWSER="firefox"

# Program defaults
export BC_ENV_ARGS="${HOME}/.bc"
export GIT_TEMPLATE_DIR=~/.git_template
export FZF_DEFAULT_COMMAND='rg --files'
export PIPENV_VENV_IN_PROJECT=1
export LESS="-R --quit-if-one-screen --no-init --mouse --wheel-lines 3"

# ---------- Completion ----------

if [ "$(command -v aws_completer)" ]; then
    complete -C "aws_completer" aws
fi
