" Markdown previews with pandoc
" Uses template at .pandoc/templates/gfm.html

let s:preview_file = tempname()

" Create a rendered preview html file
" Return success status
function! s:createPreview()
    let cmd = "pandoc --standalone --from gfm --to html --template gfm"
    let cmd .= " --output " . s:preview_file
    let cmd .= " " . expand("%:p")
    call system(cmd)
    if v:shell_error
        return 0
    endif
    return 1
endfunction

" Get browser to open preview with
function! s:getBrowser()
    let benv = getenv("BROWSER")
    if benv != v:null
        return benv
    endif
    return "firefox"
endfunction

" Open current preview html file
function! s:showPreview()
    let browser = s:getBrowser()
    let cmd = browser . " " . s:preview_file
    call system(cmd)
    if v:shell_error
        echoerr "Could not open browser"
        echoerr cmd
    endif
endfunction

" Main function
" Creates preview html file and opens it in browser
function! s:PreviewMd()
    let preview_created = s:createPreview()
    if preview_created
        call s:showPreview()
    endif
endfunction

command! MdPreview call s:PreviewMd()
command! MdRegen call s:createPreview()
