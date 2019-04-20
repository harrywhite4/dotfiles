set nocompatible              " be iMproved, required

filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins 
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-airline/vim-airline'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'tpope/vim-rhubarb'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'janko-m/vim-test'
Plugin 'w0rp/ale'
Plugin 'brooth/far.vim'

" Language specific plugins
" Plugin 'klen/python-mode'
Plugin 'vim-python/python-syntax'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'davidhalter/jedi-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'othree/html5.vim'
Plugin 'posva/vim-vue'
Plugin 'fatih/vim-go'
Plugin 'jparise/vim-graphql'
Plugin 'mustache/vim-mustache-handlebars'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Airline
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'y', 'error', 'warning' ]
    \ ]
let g:airline#extensions#virtualenv#enabled = 0


" Python-syntax
let g:python_highlight_all = 1

" Pymode
" Defaults https://github.com/python-mode/python-mode/blob/develop/doc/pymode.txt
let g:pymode_python = 'python3'
let g:pymode_lint = 0
let g:pymode_breakpoint = 1
let g:pymode_run = 0
let g:pymode_motion = 0
let g:pymode_rope = 1
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_rope_lookup_project = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_goto_definition_bind = '<C-]>'
let g:pymode_doc = 0
let g:pymode_folding = 0
let g:pymode_breakpoint = 0
let g:pymode_options_max_line_length = 100

" Jedi
let g:jedi#completions_command = "<C-Space>"
let g:jedi#goto_assignments_command = "<leader>ja"
let g:jedi#usages_command = "<leader>ju"
let g:jedi#goto_command = "<C-]>"
let g:jedi#documentation_command = ""
let g:jedi#rename_command = "<leader>jr"
let g:jedi#show_call_signatures = "0"
let g:jedi#popup_on_dot = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0

" vim-go settings
" disable fmt on save since we using ale for this
let g:go_fmt_autosave = 0

" ctrlp settings
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_lazy_update = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](node_modules|venv|__pycache__|data)|(\.(git|hg|svn|tox|venv))$',
  \ 'file': '\v\.(exe|so|dll|pyc|djcache)$',
  \ 'link': '',
  \ }

" vim-test settings
let test#strategy = 'vimterminal'
let test#python#runner = 'djangotest'
let test#python#djangotest#executable = 'pipenv run python manage.py test'
let test#go = 'gotest'
let test#go#gotest#options = '-v'

" ale settings
let g:ale_linters = {
  \ 'python': ['flake8'],
  \ 'javascript': ['eslint'],
  \ 'go': ['gofmt', 'govet']
  \ }
let g:ale_fixers = {
  \ 'go': ['gofmt'],
  \ 'python': ['autopep8']
  \ }
let g:ale_lint_on_text_changed = 'never'
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_echo_cursor = 1
autocmd FileType go let b:ale_fix_on_save = 1 " Fix on save for golang

" Leader
let mapleader = ","

" Backspace
set backspace=indent,eol,start

" Use ripgrep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

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

" Colors
set background=dark

try
    colorscheme solarized
catch
endtry

" Indentation
set expandtab
set softtabstop=4
set shiftwidth=4
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 softtabstop=2
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2
autocmd FileType json setlocal shiftwidth=2 softtabstop=2
autocmd FileType go setlocal tabstop=4

" Misc stuff
syntax enable
set number
set mouse=a

" Vue
autocmd FileType vue syntax sync fromstart

" Spellcheck
map <leader>ss :setlocal spell!<cr>
hi SpellBad cterm=underline ctermfg=red

" Folding
set foldmethod=indent
set foldnestmax=2
set foldlevel=2

" Windows
set equalalways
set eadirection="hor"

" Extra maps
map <leader>w :w<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>
map <leader>g :Gstatus<cr>
map <leader>t :TestNearest<cr>
map <leader>l :TestLast<cr>
map <leader>d :setlocal filetype=htmldjango<cr>
map <leader>x <C-W>x
map <leader>i :ALEDisableBuffer<cr>
map <leader>f <Plug>(ale_fix)
map <leader>2 :setlocal shiftwidth=2 softtabstop=2<cr>
map <leader>e :bo terminal ++close ++rows=10<cr>
map <leader>z :bo terminal ++close ++rows=30 lazygit<cr>

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
