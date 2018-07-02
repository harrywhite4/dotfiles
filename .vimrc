set nocompatible              " be iMproved, required

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'klen/python-mode'
Plugin 'pangloss/vim-javascript'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-rhubarb'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jarrodctaylor/vim-python-test-runner'
Plugin 'posva/vim-vue'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Pymode
" Defaults https://github.com/python-mode/python-mode/blob/develop/doc/pymode.txt
" let g:pymode = 0
let g:pymode_python = 'python3'
let g:pymode_lint_on_write = 0
let g:pymode_breakpoint = 0
let g:pymode_run = 0
let g:pymode_motion = 0
let g:pymode_rope = 0
let g:pymode_rope_completion = 0

" Leader
let mapleader = ","

" Command completion
set wildmode=list:longest,full
set wildmenu

" Ignore case when searching except when caps used
set ignorecase
set smartcase

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Allow switching from unsaved buffer
set hidden

" Turn off backups
set nobackup
set nowb
set noswapfile

" Give cursor 7 lines
set so=7

" Spellcheck
map <leader>ss :setlocal spell!<cr>

" Colors
set background=dark

try
    colorscheme solarized
catch
endtry

" Misc stuff
syntax enable
set number
set expandtab
set tabstop=2
set shiftwidth=2

" Extra maps
map <leader>w :w<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" Toggle nerdtree on ctrl-n
map <C-n> :NERDTreeToggle<CR>
" Open nerdtree by default if no file specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
