set nocompatible

runtime autoload/plug.vim
if exists("*plug#begin")
    call plug#begin('~/.vim/plugged')

    " Plugins
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-commentary'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-unimpaired'
    Plug 'jlanzarotta/bufexplorer'
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'dikiaap/minimalist'
    Plug 'neomake/neomake'
    Plug 'liuchengxu/vim-which-key'

    " Language specific plugins
    Plug 'fatih/vim-go'
    Plug 'davidhalter/jedi-vim'

    call plug#end()
endif

" -------------------- Base settings --------------------

" Open augroup
augroup mygroup
autocmd!

" Syntax highlighting
syntax enable

" Load a .vimrc from current directory as well if present
set exrc

" Key timeouts
set ttimeout
set ttimeoutlen=100
set timeout
set timeoutlen=500

" Auto reload buffers
set autoread

" Show line numbers
set number

" Show signs in number column
if has("patch-8.1.1564")
    set signcolumn=number
endif

" Number formats
set nrformats-=octal

" Enable mouse support
set mouse=a

" Never use the bell
set belloff=all

" Leader
let mapleader = "\<Space>"

" Backspace over anything
set backspace=indent,eol,start

" Statusline
set laststatus=2

" Tags
set tags^=.git/tags

" Command history
set history=200

" Echo commands
set showcmd

" Show incremental search
set incsearch

" Use popup for previews on recent vim
if has("patch-8.1.1714")
    set previewpopup=height:10,width:60
endif

" Patterns ignored when using wildcards
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

" Line display
set display=lastline

" Use ripgrep if avaliable
if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case
endif

" Command completion
set wildmode=list:longest,full
set wildmenu

" Completion
set completeopt=menu,menuone,noinsert
set complete=.,w,b,u,t
set pumheight=10
if has("patch-8.1.1880")
    " Enable popups for completion items in recent vim
    set completeopt+=popup
endif

" Ignore case when searching except when caps used
set ignorecase
set smartcase

" Allow switching from unsaved buffer
set hidden

" Turn off backups
set nobackup
set nowritebackup
set noswapfile

" Give cursor 7 lines
set scrolloff=7

" Turn off modelines
set nomodeline

" Dictionary
set dictionary=/usr/share/dict/words

" Chars for list mode
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" Always show how many lines affected
set report=0

" Let vim set window title
set title

" Indentation
set expandtab
set softtabstop=-1
set shiftwidth=4
autocmd FileType html setlocal shiftwidth=2
autocmd FileType htmldjango setlocal shiftwidth=2
autocmd FileType yaml setlocal shiftwidth=2
autocmd FileType cloudformation setlocal shiftwidth=2
autocmd FileType json setlocal shiftwidth=2
autocmd FileType go setlocal tabstop=4

" Format programs
autocmd Filetype python setlocal formatprg=autopep8\ -
autocmd Filetype go setlocal formatprg=gofmt

" Lang specific settings
" Sync vue files from the start
autocmd FileType vue syntax sync fromstart
" Use omnifunc from jedi
autocmd FileType python setlocal omnifunc=jedi#completions

" Folding
set foldmethod=indent
set foldnestmax=20
set foldlevelstart=20

" Windows
set equalalways
set eadirection="hor"

" Show column at textwidth +1 if textwidth is set
set colorcolumn=+1

" GUI
set guioptions=PdimgtrL

" Formatting (see :h fo-table)
set formatoptions=crqnlj
set formatlistpat="\v^\s*(\d+[\]:\.\)\}\t ]|[\-\+\*]\s)\s*"
autocmd FileType text,markdown,gitcommit setlocal formatoptions+=t
autocmd FileType markdown,python setlocal textwidth=100
autocmd FileType gitcommit setlocal textwidth=72

" Spelling (turn on spell checking for these filetypes)
autocmd Filetype gitcommit setlocal spell
autocmd Filetype pullrequest setlocal spell

" Colors
set background=dark

" Highlights
autocmd colorscheme *
    \ highlight link Terminal Normal |
    \ highlight DiffAdded cterm=NONE ctermfg=64 gui=NONE guifg=#5f8700 |
    \ highlight DiffRemoved cterm=NONE ctermfg=167 gui=NONE guifg=#d75f5f |
    \ highlight link pythonClassVar Function |
    \ highlight StatusLineTerm cterm=bold ctermfg=150 ctermbg=239 gui=bold guifg=#afd787 guibg=#4e4e4e |
    \ highlight StatusLineTermNC cterm=NONE ctermfg=150 ctermbg=239 gui=NONE guifg=#afd787 guibg=#4e4e4e |
    \ highlight User1 cterm=bold ctermfg=255 ctermbg=59 gui=bold guifg=#eeeeee guibg=#5f5f5f |
    \ highlight User2 cterm=bold ctermbg=24 gui=bold guibg=#005f87 |
    \ highlight User3 cterm=bold ctermbg=239 ctermfg=167 gui=bold guibg=#4e4e4e guifg=#d75f5f

autocmd colorscheme minimalist
    \ highlight SignColumn ctermbg=234 |
    \ highlight PMenu ctermbg=237

" Colorscheme with fallback
try
    colorscheme minimalist
catch
    colorscheme desert
endtry

" Move cursor to last position when opening file if appropriate
" Taken from defaults.vim
autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

" Statusline, plus functions used in statusline
function! GetModified()
    if !&modifiable
        return "[NM]"
    endif
    if &modified
        return "[Modified]"
    endif
    return ""
endfunction

function! GetBranchName()
    if exists("*FugitiveHead")
        let branchName = FugitiveHead()
        if len(branchName)
            return "[" . branchName . "] "
        endif
    endif
    return ""
endfunction

set statusline=
set statusline+=%1*
set statusline+=\ %n\                      " Buffer number
set statusline+=%{GetBranchName()}\        " Git branch
set statusline+=%2*
set statusline+=%(\ %h%w%q\ %)             " Flags
set statusline+=%3*
set statusline+=%(\ %{GetModified()}%r%)  " Error Flags
set statusline+=%<%0*
set statusline+=\ %f                       " File name
set statusline+=%=                         " Seperate left and right
set statusline+=%2*
set statusline+=\ %y\                      " Type
set statusline+=%1*
set statusline+=\ %LL\ %p%%\               " Stats

" Netrw settings
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_altfile = 1
let g:netrw_sizestyle = "h"
let g:netrw_fastbrowse = 0

" -------------------- Functions --------------------

" Stips whitespace while maintaining cursor position
function! StripTrailingWhitespace()
  if !&binary && &filetype != 'diff'
    normal mz
    normal Hmy
    %s/\s\+$//e
    normal 'yz<CR>
    normal `z
  endif
endfunction

" Format file with gq
function! FormatFile()
    normal mz
    normal Hmy
    normal gggqG
    normal 'yz<cr>
    normal 'z
endfunction

" If there is a window at pos close it
function! CloseWin(pos)
    let cur = winnr()
    let id = winnr(a:pos)
    if cur != id
        execute id . "wincmd c"
    endif
endfunction

" Toggle auto formatting
function! ToggleAutoFormat()
    if stridx(&formatoptions, "a") == -1
        setlocal formatoptions+=a
        echomsg "Auto format on"
    else
        setlocal formatoptions-=a
        echomsg "Auto format off"
    endif
endfunction

" Copy value to clipboard and print
function! CopyAndPrint(value)
    let @+ = a:value
    echo @+
endfunction

" -------------------- Commands --------------------

command! -nargs=1 -complete=dir Tabdir :tabnew | lcd <args> | Ex
command! -nargs=+ Rg silent! grep! <args> | redraw! | botright copen
command! -nargs=+ Rgw Rg -w <args>
command! -nargs=1 Type setlocal filetype=<args>
command! -nargs=1 Fileat Gedit <args>:%
command! -nargs=+ Pydoc terminal ++close pipenv run python -m pydoc <args>
command! MdPreview terminal ++hidden ++close sh -c "pandoc % -o ~/preview.html && firefox ~/preview.html"
command! GfmPreview terminal ++hidden ++close sh -c "grip % --export ~/preview.html && firefox ~/preview.html"
command! PrTemplate read .github/pull_request_template.md
command! Bufonly %bd | e#
command! -nargs=1 PipenvOpen :call PipenvOpen("<args>")
command! SessionSave mks! ~/session.vim
command! Retag !./.git/hooks/ctags
" Import sort (sort by second word)
command! -range Isort <line1>,<line2>sort /\w\+ /
" Wrapper on neomake
command! Make Neomake! | bo copen

" -------------------- Mappings --------------------

let g:which_key_map =  {}

" Formatting
map Q gq
" FZF
nnoremap <C-p> :FZF<cr>
"  Move around
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
" Strip whitespace
nnoremap <F2> :call StripTrailingWhitespace()<cr>
" Toggle spellcheck
nnoremap <F3> :setlocal spell!<cr>
" Toggle auto-format
nnoremap <F4> :call ToggleAutoFormat()<cr>
" Check files to reload
nnoremap <F5> :checktime<cr>
" Disable ale for this duffer
nnoremap <F6> :NeomakeToggleBuffer <bar> NeomakeClean<cr>
" Format file
nmap <F8> :call FormatFile()<cr>
" Change indentation
let g:which_key_map.i = {'name': 'Indentation'}
let g:which_key_map.i.2 = '2 spaces'
nnoremap <leader>i2 :setlocal shiftwidth=2<cr>
let g:which_key_map.i.4 = '4 spaces'
nnoremap <leader>i4 :setlocal shiftwidth=4<cr>
" Paste
let g:which_key_map.p = 'Clipboard paste'
nnoremap <leader>p "+]p
" Buffer explorer
let g:which_key_map.b = 'Buffer menu'
nnoremap <leader>b :BufExplorer<cr>
" Open terminal
let g:which_key_map.t = {'name': 'Terminal'}
let g:which_key_map.t.b = 'Terminal below'
nnoremap <leader>tb :Term<cr>
let g:which_key_map.t.t = 'Terminal tab'
nnoremap <leader>tt :TabTerm<cr>
" Fzf mappings
let g:which_key_map.f = {'name': 'Find'}
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>ft :Tags<cr>
" Git maps
let g:which_key_map.g = {'name': 'Git'}
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>ge :Gedit :<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gb :Gblame<cr>
" Grep word under cursor
let g:which_key_map.r = 'Search for word'
nnoremap <leader>r :Rgw <C-r><C-w>
" Substitute word under cursor
let g:which_key_map.s = 'Substitute word'
nnoremap <leader>s :%s/\<<cword>\>/
" Copy file path to register
let g:which_key_map.y = {'name': 'Yank'}
let g:which_key_map.y.f = 'Copy filename'
nnoremap <leader>yf :call CopyAndPrint(expand("%"))<cr>
let g:which_key_map.y.i = 'Copy import path'
nnoremap <leader>yi :ImportPath<cr>
" Save
let g:which_key_map.w = 'Save'
nnoremap <leader>w :w<cr>

" Insert mode maps
imap <C-@> <C-Space>
imap <C-Space> <C-x><C-o>
inoremap <C-]> <C-x><C-]>
inoremap <C-f> <C-x><C-f>
inoremap <C-l> <C-x><C-l>
inoremap <expr> <C-k> pumvisible() ? "\<Up>" : "\<C-x>\<C-k>"
inoremap <expr> <C-j> pumvisible() ? "\<Down>" : "\<C-j>"
inoremap <expr> <C-n> pumvisible() ? "\<Down>" : "\<C-n>"
inoremap <expr> <C-p> pumvisible() ? "\<Up>" : "\<C-p>"

" Visual mode maps
vnoremap <leader>s :s/\<<C-r>0\>/
vnoremap <leader>y "+y

" -------------------- Plugin Settings --------------------

" Filetype mappings
let g:which_key_map.l = {'name': 'Language specific'}
let g:which_key_map[']'] = 'Goto'
autocmd filetype python
    \ nnoremap <buffer> <leader>] :call jedi#goto()<cr> |
    \ nnoremap <buffer> <leader>lk :call jedi#show_documentation()<cr> |
    \ nnoremap <buffer> <leader>lr :call jedi#usages()<cr> |
    \ nnoremap <buffer> <leader>ln :call jedi#rename()<cr>
autocmd filetype go nnoremap <buffer> <leader>] :GoDef<cr>

" Which key
let g:which_key_use_floating_win = 1
runtime autoload/which_key.vim
if exists('*which_key#register')
    call which_key#register('<Space>', "g:which_key_map")
    " Only setup these maps if registration occured
    nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
    vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
endif

" Neomake

" Automake when reading / editing (after 100ms), and when writing.
runtime autoload/neomake/configure.vim
if exists('*neomake#configure#automake')
    call neomake#configure#automake('nrw', 100)
endif

" Highlights
let g:neomake_highlight_columns = 0
let g:neomake_error_sign = {
 \ 'text': 'E>',
 \ 'texthl': 'Error',
 \ }
let g:neomake_warning_sign = {
 \   'text': 'W>',
 \   'texthl': 'Todo',
 \ }
let g:neomake_message_sign = {
  \   'text': 'M>',
  \   'texthl': 'Normal',
  \ }
let g:neomake_info_sign = {
  \ 'text': 'I>',
  \ 'texthl': 'Normal'
  \ }

" Custom makers
let g:neomake_cloudformation_cfnlint_maker = {
    \ 'exe': 'cfn-lint',
    \ 'args': ['--template', '%t', '--format', 'parseable'],
    \ 'append_file': 0,
    \ 'errorformat': '%f:%l:%c:%*\d:%*\d:%m'
    \ }


" Enabled makers
let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_vue_enabled_makers = ['eslint']
let g:neomake_cloudformation_enabled_makers = ['cfnlint']
let g:neomake_go_enabled_makers = ['go', 'govet']
let g:neomake_cpp_enabled_makers = ['cppcheck', 'cpplint']

" Linter args
let g:neomake_mypy_args = [
    \ '--show-column-numbers',
    \ '--config-file',
    \ '~/.config/mypy/config',
    \ ]
let g:neomake_yamllint_args = [
    \ '-f',
    \ 'parsable',
    \ ]
let g:neomake_eslint_args = [
    \ '--format=compact'
    \ ]

" Load matchit plugin (comes with vim)
if !exists('g:loaded_matchit')
    runtime! macros/matchit.vim
endif

" Polyglot
let g:polyglot_disabled = ['csv']
let g:vim_json_warnings = 0
let g:python_highlight_all = 0
let g:python_highlight_space_errors = 0
let g:python_highlight_builtin_objs = 1
let g:python_highlight_builtin_funcs = 1
let g:python_highlight_builtin_types = 1
let g:python_highlight_class_vars = 1
let g:python_highlight_operators = 1
let g:python_highlight_exceptions = 1
let g:vim_markdown_new_list_item_indent = 0

" FZF
let g:fzf_layout = {'window': {'width': 0.8, 'height': 0.6}}

" Jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#auto_initialization = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = "0"

" vim-go settings
let g:go_fmt_autosave = 1
let g:go_fmt_fail_silently = 1 " Should see errors through other means
let g:go_version_warning = 0
let g:go_def_mapping_enabled = 0 " Overrides tags mappings
let g:go_template_autocreate = 0
" vim-go syntax
let g:go_highlight_string_spellcheck = 0
let g:go_highlight_diagnostic_errors = 0
let g:go_highlight_diagnostic_warnings = 0

" Buf explorer
let g:bufExplorerDisableDefaultKeyMapping=1

augroup END
