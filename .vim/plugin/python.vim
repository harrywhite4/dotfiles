" Get function / class name part of path
" searches up from cursor
function! s:getImportPathEnd()
    let cline = line('.')
    let identifiers = []
    " Iterate from current line backwards
    for linenr in range(cline, 1, -1)
        " Check for function or class definition
        let matches = matchlist(getline(linenr), '^\( *\)\(def\|class\) \([^(:]\+\)[(:]')
        " If we got a match
        if len(matches) > 0
            let indentation = len(matches[1])
            let identifier = matches[3]
            let identifiers = add(identifiers, identifier)
            if indentation == 0
                break
            endif
        endif
    endfor

    " Get end of identifier
    let identifiers = reverse(identifiers)
    return join(identifiers, '.')
endfunction

" Given a file path return the head (up one level if dir)
function! s:getHead(path)
    return fnamemodify(a:path, ":h")
endfunction

" Given a file path return the tail
function! s:getTail(path)
    return fnamemodify(a:path, ":t")
endfunction

" Given a file path return the filename without suffix
function! s:getFilename(path)
    return fnamemodify(a:path, ":t:r")
endfunction

" Check if a file exists
function! s:fileExists(path)
    return !empty(glob(a:path))
endfunction

" Get file part of path
function! s:getImportPathStart()
    " Get full path to current file
    let path = expand('%:p')
    let parts = [s:getFilename(path)]

    while 1
        let path = s:getHead(path)
        " If we got to top of file tree
        if path == '/'
            break
        endif

        " If there is no init py in path
        if !s:fileExists(path . '/__init__.py')
            break
        endif
        let parts = add(parts, s:getTail(path))
    endwhile

    let parts = reverse(parts)
    return join(parts, '.')
endfunction

" Get import path for closest definition
function! GetImportPath()
    return s:getImportPathStart() . '.' . s:getImportPathEnd()
endfunction
