call plug#begin('~/.vim/plugged')

" Plugins
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
" Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
" Plug 'airblade/vim-gitgutter'
Plug 'jlanzarotta/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'

" Language specific plugins
Plug 'fatih/vim-go'
Plug 'davidhalter/jedi-vim'

call plug#end()

" Jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#auto_initialization = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = "0"
autocmd FileType python setlocal omnifunc=jedi#completions

" vim-go settings
" disable fmt on save since we using ale for this
let g:go_fmt_autosave = 0
let g:go_version_warning = 0
let g:go_def_mapping_enabled = 0

" ctrlp settings
let g:ctrlp_follow_symlinks = 0
let g:ctrlp_lazy_update = 0
" Much faster listing when in a git repo
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" vim-test settings
function! SmTerminalStrategy(cmd)
    execute "bo terminal ++rows=15 ".a:cmd
endfunction
let g:test#custom_strategies = {'smterminal': function('SmTerminalStrategy')}
let test#strategy = 'smterminal'
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

" Buf explorer
let g:bufExplorerDisableDefaultKeyMapping=1

" Leader
let mapleader = ","

" Backspace
set backspace=indent,eol,start

" Statusline
set laststatus=2

" Tags
set tags+=./.git/tags

" Wildignore
set wildignore=*.exe,*.dll,*.so,*.pyc
set wildignore+=*/.git/objects/*
set wildignore+=*/.git/logs/*
set wildignore+=*/.git/refs/*
set wildignore+=*/__pycache__/*
set wildignore+=*__pycache__
set wildignore+=*/.venv/*
set wildignore+=*/.tox/*
set wildignore+=*/.mypy_cache/*
set wildignore+=*/node_modules/*
set wildignore+=*/dist/*

" Path
set path=.,**

" Statusline
function GetModified()
    if !&modifiable
        return "[NM]"
    endif
    if &modified
        return "[Modified]"
    endif
    return ""
endfunction

function GetLintErrorCount()
    if exists("*ale#statusline#Count")
        let lintErrorCount = ale#statusline#Count(bufnr(''))['total']
        if lintErrorCount > 0
            return lintErrorCount
        endif
    endif
    return ''
endfunction

function GetBranchName()
    if exists("*FugitiveHead")
        let branchName = FugitiveHead()
        if len(branchName)
            return "[" . branchName . "] "
        endif
    endif
    return ""
endfunction

set statusline=
set statusline+=%#PmenuSel#
set statusline+=\ %n\                      " Buffer number
set statusline+=%{GetBranchName()}\        " Git branch
set statusline+=%#DiffText#
set statusline+=%(\ %h%w%q%)                 " Flags
set statusline+=%#DiffDelete#
set statusline+=%(\ %{GetLintErrorCount()}%{GetModified()}%r%)       " Error Flags
set statusline+=%<%0*
set statusline+=\ %f                         " File name
set statusline+=%=                         " Seperate left and right
set statusline+=%#DiffText#
set statusline+=\ %y\                        " Type
set statusline+=%#PMenuSel#
set statusline+=\ %LL\ %p%%\                " Stats

" Highlights
autocmd colorscheme *
    \ hi link Terminal Normal |
    \ hi StatusLine cterm=NONE ctermfg=7 ctermbg=0 |
    \ hi StatusLineNC cterm=NONE ctermfg=10 ctermbg=0 |
    \ hi StatusLineTerm cterm=NONE ctermfg=2 ctermbg=0 |
    \ hi StatusLineTermNC cterm=NONE ctermfg=6 ctermbg=0 |
    \ hi SignColumn ctermbg=0 ctermfg=14

" Netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_altfile = 1
let g:netrw_sizestyle = "h"
let g:netrw_fastbrowse = 0

" Use ripgrep if avaliable
if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case
endif

" Command completion
set wildmode=list:longest,full
set wildmenu

" Completion
set completeopt=menuone,longest,preview
set complete=.,w,b,u,t

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
    colorscheme slate
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
hi SpellBad cterm=underline ctermfg=red

" Folding
set foldmethod=indent
set foldnestmax=2
set foldlevel=2

" Windows
set equalalways
set eadirection="hor"

" Misc functions
function! StripTrailingWhitespace()
  " Stips whitespace while maintaining cursor position
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

" Mappings
map <F2> :call StripTrailingWhitespace()<cr>
map <F3> <Plug>(ale_fix)
map <F4> :setlocal spell!<cr>
map <leader>2 :setlocal shiftwidth=2 softtabstop=2<cr>
map <leader>4 :setlocal shiftwidth=4 softtabstop=4<cr>
map <leader>d :setlocal filetype=htmldjango<cr>
map <leader>b :BufExplorer<cr>
map <leader>e :bo terminal ++close ++rows=10<cr>
" map <leader>g :15split \| Gedit :<cr>
map <leader>g :Gstatus<cr>
map <leader>i :ALEDisableBuffer<cr>
map <leader>l :TestLast<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>
map <leader>r :%s/\<<C-r><C-w>\>/
map <leader>t :TestNearest<cr>
map <leader>w :w<cr>
map <leader>x :Ex<cr>
map <leader>z :bo terminal ++close ++rows=30 lazygit<cr>
" Insert mode maps
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
" Filetype mappings
autocmd filetype python map <leader><leader> :call jedi#goto()<cr>
autocmd filetype go map <leader><leader> :GoDef<cr>
