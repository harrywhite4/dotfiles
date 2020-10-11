FROM alpine:latest

# Core stuff
RUN apk add \
    mandoc man-pages \
    zsh zsh-vcs zsh-doc \
    bash bash-doc \
    less less-doc \
    git git-doc \
    vim vim-doc \
    curl curl-doc \
    python3 python3-doc \
    tmux tmux-doc \
    ripgrep ripgrep-doc \
    fzf fzf-doc

RUN addgroup --system harry && \
    adduser --system --ingroup harry --home /home/harry --shell /bin/zsh harry
USER harry

COPY --chown=harry:harry . /home/harry/dotfiles

RUN cd /home/harry/dotfiles && ./install.sh

ENV PAGER=less
ENV TERM=xterm-256color
WORKDIR /home/harry
CMD ["zsh"]
