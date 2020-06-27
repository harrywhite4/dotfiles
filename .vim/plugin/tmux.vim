" Commands for creating tmux windows / panes with dir

" Get final directory from directory passed to command
" Uses current dir if not provided
function! s:GetDir(userDir)
    " Use user provided dir if avaliable
    if strlen(a:userDir)
        " Make relative paths absolute
        return fnamemodify(a:userDir, ':p')
    endif
    " Use newrw dir if in that buffer
    if exists("b:netrw_curdir")
        return b:netrw_curdir
    endif
    return getcwd()
endfunction


function s:Execute(command)
    execute "silent !" . a:command
    redraw!
endfunction


function! s:TmuxSplit(dir)
    let termdir = s:GetDir(a:dir)
    let cmd = 'tmux split-window -p 33 -c ' . termdir
    call s:Execute(cmd)
endfunction


function! s:TmuxWindow(dir)
    let termdir = s:GetDir(a:dir)
    let cmd = 'tmux new-window -c ' . termdir
    call s:Execute(cmd)
endfunction

command! -nargs=? -complete=dir TmuxSplit call s:TmuxSplit(expand("<args>"))
command! -nargs=? -complete=dir TmuxWindow call s:TmuxWindow(expand("<args>"))
