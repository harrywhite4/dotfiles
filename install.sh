#!/bin/sh
set -e
TODIR="${HOME}"
VIM_PLUGINS_DIR=~/.vim/plugged
VIM_PLUG_FILE=~/.vim/autoload/plug.vim

show_help() {
    cat << EOF
${0} [OPTION]...
Install dotfiles

Options:
--help     Show help
--clean    Remove installed vim-plug plugins
--quiet    Print less detailed info
EOF
}

quiet=0
clean=0

# Flag arg parsing
for i in "$@"; do
    case ${i} in
        --help)
            show_help
            exit 0
            ;;
        --quiet)
            quiet=1
            ;;
        --clean)
            clean=1
            ;;
    esac
done

# Clean plugins if required
if [ -d "${VIM_PLUGINS_DIR}" ] && [ "${clean}" -eq 1 ]; then
    echo "Removing installed vim plugins..."
    rm -r "${VIM_PLUGINS_DIR}"
fi

# Print if verbose
# Argument 1: String to print
vprint() {
    if [ "${quiet}" -eq 0 ]; then
        echo "${1}"
    fi
}

# Create a symlink to file under current dir
# Argument 1: Path to file / dir to be linked to (relative to current dir)
# Argument 2: Path to directory link should be placed in
makelink() {
    linkname="${2}/${1}"
    # If not already a symlink
    if [ ! -h "${linkname}" ]; then
        ln -s "${PWD}/${1}" "${linkname}"
        vprint "Linked ${linkname} to ${PWD}/${1}"
    else
        vprint "${linkname} was already a symlink"
    fi
}

# Symlink dotfiles
find "${PWD}" -maxdepth 1 -type f -name '.*' | while read -r path; do
    file=$(basename "${path}")
    makelink "${file}" "${TODIR}"
done

# link from inside .vim
mkdir -p "${TODIR}/.vim"
for vpath in "${PWD}"/.vim/*; do
    vfile=$(basename "${vpath}")
    makelink ".vim/${vfile}" "${TODIR}"
done

# Link .config files
find .config -type f | while read -r cpath; do
    cdir=$(dirname "${cpath}")
    mkdir -p "${TODIR}/${cdir}"
    makelink "${cpath}" "${TODIR}"
done

# Symlinked directories
makelink ".git_template" "${TODIR}"
makelink ".pandoc" "${TODIR}"

if [ -x "$(command -v wget)" ]; then
    # Install vim-plug if required
    if [ ! -f "${VIM_PLUG_FILE}" ]; then
	echo "Installing vim-plug..."
        # Create autoload dir
	mkdir -p "$(dirname ${VIM_PLUG_FILE})"
	# Install vim-plug
	wget -O "${VIM_PLUG_FILE}" \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Run PlugInstall if required
    if [ ! -d "${VIM_PLUGINS_DIR}" ]; then
	echo "Installing vim plugins..."
	vim --not-a-term +PlugInstall +qall > /dev/null
    fi
else
    echo "wget not installed, vim plugin setup skipped"
fi

echo "Done!"
