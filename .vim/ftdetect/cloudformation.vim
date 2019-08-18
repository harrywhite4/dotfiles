function! DetectCf()
    let line = getline(1)
    if match(line, "^AWSTemplateFormatVersion") != -1
        set filetype=cloudformation
    endif
endfunction

au BufRead *.yaml call DetectCf()
au BufRead *.yml call DetectCf()
