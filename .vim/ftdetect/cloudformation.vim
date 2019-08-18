function! DetectCf()
    let line = getline(1)
    if match(line, '\v^AWSTemplateFormatVersion:.*[0-9]{4}-[0-9]{2}-[0-9]{2}') != -1
        set filetype=cloudformation
    endif
endfunction

au BufRead *.yaml,*.yml call DetectCf()
