#!/bin/sh
# Script to install dotfiles
# Written in POSIX sh for compatibility
set -e
todir="${HOME}"
vim_plugins_dir=~/.vim/plugged
vim_plug_file=~/.vim/autoload/plug.vim

show_help() {
    cat << EOF
${0} [OPTION]...
Install dotfiles

Options:
--help     Show help
--un       Uninstall by removing symlinks
--clean    Remove installed vim-plug plugins before installing
EOF
}

uninstall=0
clean=0

# Flag arg parsing
for i in "$@"; do
    case ${i} in
        --help)
            show_help
            exit 0
            ;;
        --clean)
            clean=1
            ;;
        --un)
            uninstall=1
            ;;
    esac
done

# Clean plugins if required
if [ -d "${vim_plugins_dir}" ] && [ "${clean}" -eq 1 ]; then
    echo "Removing installed vim plugins..."
    rm -r "${vim_plugins_dir}"
fi

# Backup an exiting file
# Argment 1: File path
backup_file() {
    backup_file="${1}.bak"
    if [ -e "${backup_file}" ]; then
        echo "Could not backup ${1} to ${backup_file} file already exists"
        exit 1
    fi
    echo "Backing up ${1} to ${backup_file}"
    mv "${1}" "${1}.bak"
}

# Create a symlink to file under current dir
# Argument 1: Path to file / dir to be linked to (relative to current dir)
# Argument 2: Path to directory link should be placed in
make_link() {
    linkname="${2}/${1}"
    if [ -h "${linkname}" ]; then
        echo "${linkname} was already a symlink"
    else
        if [ -f "${linkname}" ]; then
            backup_file "${linkname}"
        fi
        ln -s "${PWD}/${1}" "${linkname}"
        echo "Linked ${linkname} to ${PWD}/${1}"
    fi
}

# Remove a symlink if it exists
# Same arguments as make_link above
remove_link() {
    linkname="${2}/${1}"
    if [ -h "${linkname}" ]; then
        rm "${linkname}"
        echo "Removed symlink ${linkname}"
    else
        echo "Symlink ${linkname} doesn't exist"
    fi
}

# Process a symlink by creating it if installing or deleting if uninstalling
# Same arguments as make_link above
process_link() {
    if [ "${uninstall}" -eq 1 ]; then
        remove_link "$1" "$2"
    else
        make_link "$1" "$2"
    fi
}

# Symlink dotfiles
find "${PWD}" -maxdepth 1 -type f -name '.*' | while read -r path; do
    file=$(basename "${path}")
    process_link "${file}" "${todir}"
done

# link from inside .vim
mkdir -p "${todir}/.vim"
for vpath in "${PWD}"/.vim/*; do
    vfile=$(basename "${vpath}")
    process_link ".vim/${vfile}" "${todir}"
done

# Link .config files
find .config -type f | while read -r cpath; do
    cdir=$(dirname "${cpath}")
    # TODO: handle putting vscode config in ~/Library/Application Support/Code on Macos
    mkdir -p "${todir}/${cdir}"
    process_link "${cpath}" "${todir}"
done

# Symlinked directories
process_link ".git_template" "${todir}"
process_link ".pandoc" "${todir}"

if [ -x "$(command -v wget)" ]; then
    # Install vim-plug if required
    if [ ! -f "${vim_plug_file}" ]; then
	echo "Installing vim-plug..."
        # Create autoload dir
	mkdir -p "$(dirname ${vim_plug_file})"
	# Install vim-plug
	wget -O "${vim_plug_file}" \
	    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    fi

    # Run PlugInstall if required
    if [ ! -d "${vim_plugins_dir}" ]; then
	echo "Installing vim plugins..."
	vim --not-a-term +PlugInstall +qall > /dev/null
    fi
else
    echo "wget is not installed, vim plugin setup skipped"
fi

echo "Done!"
