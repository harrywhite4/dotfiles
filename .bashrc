# Default editor
export EDITOR="vim"

# Prompt
export PS1="\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]\$ "

# General aliases
alias ll="ls -lah"
alias x="exit"
alias randompw="strings /dev/urandom | head -c 12 | tr -d \'\\n\' | base64"
alias rgrep="grep -nr"
alias lg="lazygit"

# Compilers
alias g++="g++-8"
export CXX="g++-8"

# AWK one liners
alias mostused="history | awk '{usage[\$2]+=1}END{for(key in usage){print key, usage[key]}}' | sort -nrk 2 | head"
alias space="df -h | awk '{if(\$6==\"/\"||NR==1){print}}'"
alias gitopen="firefox \$(git remote -v | awk '/origin/{print substr(\$2,0,length(\$2)-4);exit}')"
alias paths="echo \$PATH | awk -F ':' '{for (i=1;i<NF;i++){print \$i}}'"
alias temps="cat /sys/class/thermal/thermal_zone*/temp | awk '{print \"Core\" NR-1 \" \" \$1/1000 \"C\"}'"

# Python
alias python="python3"
alias pip="pip3"
alias pr="pipenv run"
alias prp="pipenv run python"

# Docker
alias dc="docker-compose"
alias dce="docker-compose exec"
alias dcr="docker-compose restart"

# Docker project specific
alias dcadmin="docker-compose exec web django-admin"
alias dcsql="docker-compose exec db psql --user postgres"

# Git
export GIT_TEMPLATE_DIR=~/.git_template
