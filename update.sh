#!/bin/sh
set -e

show_help() {
    cat << EOF
${0} [OPTION]...
Update dotfiles

Options:
--help      Show help
--verbose   Print additional info
EOF
}

verbose=0

# Flag arg parsing
for i in "$@"; do
    case ${i} in
        "--help")
            show_help
            exit 0
            ;;
        "--verbose")
            verbose=1
            ;;
    esac
done

# Go to top of git repo
top="$(git rev-parse --show-toplevel)"
cd "${top}"

# Print if verbose
# Argument 1: String to print
vprint() {
    if [ "${verbose}" -eq 1 ]; then
        echo "${1}"
    fi
}

echo "Copying dotfiles..."
# Merge gitconfig with gitname if avaliable
if [ -f ~/.gitname ]; then
    cat ~/.gitname .gitconfig > ~/.gitconfig
else
    cp ./.gitconfig ~/.gitconfig
fi

vprint "Copied ./.gitconfig"

# Create a symlink from $HOME to file
# Argument 1: Path of file
# Argument 2: Path to directory link should be placed in
makelink() {
    fname=$(basename "${1}")
    linkname="${2}/${fname}"
    # If not already a symlink
    if [ ! -h "${linkname}" ]; then
        ln -s "${1}" "${linkname}"
        vprint "Linked ${linkname} to ${1}"
    else
        vprint "${linkname} was already a symlink"
    fi
}

# Symlink dotfiles
dotfiles=$(find "${PWD}" -maxdepth 1 -type f -name '.*' -not -name '.gitconfig')
for file in ${dotfiles}; do
    makelink "${file}" "${HOME}"
done

echo "Copying dotdirs..."

# Copy dot dirs

# link from inside .vim
mkdir -p "${HOME}/.vim"
for vfile in "${PWD}"/.vim/*; do
    makelink "${vfile}" "${HOME}/.vim"
done

# Copy files inside .config instead of symlinking
copy_dotdirs=".config"
for dir in ${copy_dotdirs}; do
    cp --recursive "${dir}" "${HOME}"
    vprint "Copied ${dir}"
done

# Symlinked directories
symlink_dotdirs="${PWD}/.git_template"
for dir in ${symlink_dotdirs}; do
    makelink "${dir}" "${HOME}"
done

echo "Done!"
exit 0
