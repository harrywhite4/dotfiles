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
Plugin 'sheerun/vim-polyglot'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rhubarb'
" Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
" Plugin 'airblade/vim-gitgutter'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'janko-m/vim-test'
Plugin 'w0rp/ale'

" Language specific plugins
Plugin 'fatih/vim-go'
Plugin 'davidhalter/jedi-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Jedi (only using omnifunc)
let g:jedi#auto_initialization = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#popup_on_dot = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#completions_enabled = 0
autocmd FileType python setlocal omnifunc=jedi#completions

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

" Statusline
set laststatus=2
function GetLintErrorCount()
    let lintErrorCount = ale#statusline#Count(bufnr(''))['total']
    if lintErrorCount > 0
        return lintErrorCount
    endif
    return ''
endfunction
set statusline=%<%2*%h%m%r\ %3*[%{FugitiveHead()}]\ %2*%{GetLintErrorCount()}\ %1*%f%=%L\ %p%%

" Solarized highlights
autocmd colorscheme solarized
    \ hi User1 ctermbg=0 ctermfg=14 |
    \ hi User2 ctermbg=0 ctermfg=1 |
    \ hi User3 ctermbg=0 ctermfg=5 |
    \ hi Terminal ctermbg=0 |
    \ hi SignColumn ctermbg=0 ctermfg=14

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_altfile = 1
let g:netrw_sizestyle = "h"
let g:netrw_fastbrowse = 2

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
map <leader>x <C-w>x
map <leader>i :ALEDisableBuffer<cr>
map <leader>f <Plug>(ale_fix)
map <leader>2 :setlocal shiftwidth=2 softtabstop=2<cr>
map <leader>e :bo terminal ++close ++rows=10<cr>
map <leader>z :bo terminal ++close ++rows=30 lazygit<cr>
map <C-n> :NERDTreeToggle<cr>
" Insert mode maps
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" Open nerdtree by default if no file specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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
