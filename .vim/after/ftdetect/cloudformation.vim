function! DetectCfYaml()
    let line = getline(1)
    if match(line, '\v^AWSTemplateFormatVersion:\s*[''"]?\d{4}-\d{2}-\d{2}[''"]?') != -1
        setlocal filetype=yaml.cloudformation
    endif
endfunction

function! DetectCfJson()
   for linenum in range(1,2) 
       let line = getline(linenum)
       if match(line, '\v^\s*\"AWSTemplateFormatVersion\"\s*\:\s*\"\d{4}-\d{2}-\d{2}\"') != -1
           setlocal filetype=json.cloudformation
       endif
   endfor
endfunction

augroup filetypedetect
    autocmd BufRead *.yaml,*.yml call DetectCfYaml()
    autocmd BufRead *.json call DetectCfJson()
augroup END
