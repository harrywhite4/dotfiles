setlocal shiftwidth=4

" Remove leading / to handle @ imports
" where the @ dir is in 'path'
setlocal includeexpr=substitute(v:fname,'^/','','')

" Use js comment string
setlocal commentstring=//%s

syntax sync fromstart

let html_no_rendering=1
