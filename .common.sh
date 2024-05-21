# Common config for .bashrc and .zshrc

lessv=0
if [[ "$(command -v less)" ]]; then
    lessv=$(less --version | awk 'NR == 1{print $2}')
fi

# ---------- Aliases ----------

# Color aliases
alias grep="grep --color=auto"
if [[ "$OSTYPE" = linux* ]]; then
    # Assume gnu ls and diff which have --color
    alias ls="ls --color=auto"
    alias diff="diff --color=auto"
fi

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
alias randpw="tr -dc '[:graph:]' < /dev/urandom | head -c 30 | sed '\$a\\'"

# Fedoras x vim alias
if [[ "$(command -v vimx)" ]]; then
    # Since vim compiled with clipboard support is installed to vimx by the vim-X11 package on fedora
    alias vim=vimx
fi

# Pagers
LESS_SCRIPT="/usr/local/share/vim/vim82/macros/less.sh"
if [[ -f "$LESS_SCRIPT" ]]; then
    alias vless="$LESS_SCRIPT"
fi

# AWK one liners
alias mostused="history | awk '{usage[\$2]+=1}END{for(key in usage){print key, usage[key]}}' | sort -nrk 2 | head"
alias paths="echo \$PATH | awk -F ':' '{for (i=1;i<NF;i++){print \$i}}'"
alias temps="cat /sys/class/thermal/thermal_zone*/temp | awk '{print \"Thermal Zone \" NR-1 \" \" \$1/1000 \"C\"}'"
alias thisip="ip -br -4 address | awk '{if (\$2 == \"UP\") { split(\$3, a, \"/\"); print a[1] }}'"

# Git
alias gittop='cd $(git rev-parse --show-toplevel)'

# Docker
alias doco="docker-compose"

# Docker project specific
alias dcadmin="docker-compose exec web django-admin"
alias dcsql="docker-compose exec db psql --user postgres"

# Json
alias jview="view -c 'set ft=json' -"

# Open alias
if [ "$(command -v xdg-open)" ]; then
    alias open="xdg-open"
fi

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
export LESS="--RAW-CONTROL-CHARS --quit-if-one-screen --no-init"
if [[ "${lessv}" -ge 551 ]]; then
    # These options aren't available on older less versions
    LESS="${LESS} --mouse --wheel-lines 3"
fi
# This is picked up by Macos / Free BSD `ls`
export CLICOLOR=1

# ---------- Completion ----------

if [ "$(command -v aws_completer)" ]; then
    complete -C "aws_completer" aws
fi

export MANPAGER=less

# ---------- Extra ----------

# Load extra config specific to this machine
if [ -f "${HOME}/.thisrc.sh" ]; then
    source "${HOME}/.thisrc.sh"
fi
