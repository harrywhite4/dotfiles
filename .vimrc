call plug#begin('~/.vim/plugged')

" Plugins
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'altercation/vim-colors-solarized'
Plug 'jlanzarotta/bufexplorer'
Plug 'junegunn/fzf', {'dir': '~/.fzf'}
Plug 'janko-m/vim-test'
Plug 'w0rp/ale'

" Language specific plugins
Plug 'fatih/vim-go'
Plug 'davidhalter/jedi-vim'

call plug#end()

" ---------- Base settings ----------

" Open augroup
augroup mygroup
autocmd!

" Syntax highlighting
syntax enable

" Show line numbers
set number

" Enable mouse support
set mouse=a

" Leader
let mapleader = "\<Space>"

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
        let lintErrorCount = ale#statusline#Count(bufnr("%"))['total']
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
    \ highlight link Terminal Normal |
    \ highlight StatusLine cterm=NONE ctermfg=7 ctermbg=0 |
    \ highlight StatusLineNC cterm=NONE ctermfg=10 ctermbg=0 |
    \ highlight StatusLineTerm cterm=NONE ctermfg=2 ctermbg=0 |
    \ highlight StatusLineTermNC cterm=NONE ctermfg=6 ctermbg=0 |
    \ highlight SignColumn ctermbg=0 ctermfg=14

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
set completeopt=menu,longest,preview
set complete=.,w,b,u,t
set pumheight=15

" Ignore case when searching except when caps used
set ignorecase
set smartcase

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

" Lang specific settings
" Sync vue files from the start
autocmd FileType vue syntax sync fromstart
" Use omnifunc from jedo
autocmd FileType python setlocal omnifunc=jedi#completions
" Fix on save for golang
autocmd FileType go let b:ale_fix_on_save = 1

" Spellcheck
highlight SpellBad cterm=underline ctermfg=red

" Folding
set foldmethod=indent
set foldnestmax=2
set foldlevel=2

" Windows
set equalalways
set eadirection="hor"

" Formatting (see :h fo-table)
autocmd FileType * setlocal formatoptions=crql

" ---------- Functions ----------

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

" If there is a window at pos close it
function! CloseWin(pos)
    let cur = winnr()
    let id = winnr(a:pos)
    if cur != id
        execute id . "wincmd c"
    endif
endfunction

" Open terminal reusing existing
function! TermExec(command)
    " Get all terminal buffers
    let tlist = term_list()
    for bufn in tlist
        " If status is finished
        let status = term_getstatus(bufn)
        if status == "finished"
            " If has a window on this tabpage
            let window = bufwinnr(bufn)
            if window != -1
                " Reuse window
                execute window . "wincmd w"
                execute "terminal ++curwin" a:command
                return bufnr("%")
            endif
        endif
    endfor
    " Create new window
    execute "bo terminal ++rows=15" a:command
    return bufnr("%")
endfunction

" ---------- Commands ----------

command -nargs=* Term :call TermExec("<args>")
command -nargs=+ Rg :Term rg --vimgrep --color always <args>
command -nargs=+ Grep :grep! <args> | botright copen

" ---------- Mappings ----------

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
" Check files to reload
nnoremap <F5> :checktime<cr>
" Autofix lint errors
nmap <F8> <Plug>(ale_fix)
" Change indentation
nnoremap <leader>2 :setlocal shiftwidth=2 softtabstop=2<cr>
nnoremap <leader>4 :setlocal shiftwidth=4 softtabstop=4<cr>
" Explore buffers
nnoremap <leader>b :BufExplorer<cr>
" Set filetype to htmldjango
nnoremap <leader>d :setlocal filetype=htmldjango<cr>
" Open terminal
nnoremap <leader>e :bo terminal ++close ++rows=15<cr>
" Copy file path to register
nnoremap <leader>f :let @" = expand("%")<cr>
" Open git status
nnoremap <leader>g :Gstatus<cr>
" Disable ale for this duffer
nnoremap <leader>i :ALEDisableBuffer<cr>
" Run last test
nnoremap <leader>l :TestLast<cr>
" Navigate quickfix
nnoremap <leader>n :cn<cr>
nnoremap <leader>p :cp<cr>
" Close window below
nnoremap <leader>q :call CloseWin("j")<cr>
" Grep word under cursor
nnoremap <leader>r :Grep <C-r><C-w>
" Replace word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/
" Run nearest test
nnoremap <leader>t :TestNearest<cr>
" Save
nnoremap <leader>w :w<cr>

" Insert mode maps
imap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>

" Filetype mappings
autocmd filetype python
    \ nnoremap <leader><leader> :call jedi#goto()<cr> |
    \ nnoremap K :call jedi#show_documentation()<cr>
autocmd filetype go nnoremap <leader><leader> :GoDef<cr>


" ------------ Plugin Settings ----------

" FZF
let g:fzf_layout = { 'down': '~30%' }

" Jedi
let g:jedi#auto_vim_configuration = 0
let g:jedi#auto_initialization = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = "0"
" omnifunc is used in lanspecific augroup above

" vim-go settings
" disable fmt on save since we using ale for this
let g:go_fmt_autosave = 0
let g:go_version_warning = 0
let g:go_def_mapping_enabled = 0

" vim-test settings
function! SmTerminalStrategy(cmd)
    execute TermExec(a:cmd)
endfunction
let g:test#custom_strategies = {'smterminal': function('SmTerminalStrategy')}
let test#strategy = 'smterminal'
let test#python#runner = 'djangotest'
let test#python#djangotest#executable = 'pipenv run python manage.py test'
let test#go = 'gotest'
let test#go#gotest#options = '-v'

" ale settings
let g:ale_linters_explicit = 1
let g:ale_linters = {
  \ 'python': ['flake8'],
  \ 'javascript': ['eslint'],
  \ 'go': ['gofmt', 'govet'],
  \ 'cpp': ['cpplint']
  \ }
let g:ale_fixers = {
  \ 'go': ['gofmt'],
  \ 'python': ['autopep8']
  \ }
let g:ale_set_highlights = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_echo_cursor = 1

" Buf explorer
let g:bufExplorerDisableDefaultKeyMapping=1

"End augroup
augroup END
