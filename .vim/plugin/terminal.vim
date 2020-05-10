" Functions and commands for using terminal windows

" Get cwd for term options
function! s:getTermCwd()
    " Always use netrw dir if avaliable
    if exists("b:netrw_curdir")
        return b:netrw_curdir
    endif
    return getcwd()
endfunction

" Get options for running command in terminal
function! s:getRunOptions()
    return {"cwd": s:getTermCwd()}
endfunction

" Run command reusing existing terminal window
function! TermExec(command)
    let cmdlist = [&shell, &shellcmdflag, a:command]
    let options = s:getRunOptions()
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
                let options["curwin"] = 1
                call term_start(cmdlist, options)
            endif
        endif
    endfor
    " Create new window
    let options["term_rows"] = 20
    botright call term_start(cmdlist, options)
endfunction

" Get options for running shell in terminal
function! s:getTermOptions()
    let options = {"term_finish": "close", "term_kill": "hup"}
    let options["cwd"] = s:getTermCwd()
    return options
endfunction

function! TerminalBelow()
    let options = s:getTermOptions()
    let options["term_rows"] = 20
    botright call term_start(&shell, options)
endfunction

function! TerminalTab()
    let options = s:getTermOptions()
    $tab call term_start(&shell, options)
endfunction

command! -nargs=* Run :call TermExec("<args>")
command! Term call TerminalBelow()
command! TabTerm call TerminalTab()
