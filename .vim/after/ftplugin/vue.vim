" Remove leading / to handle @ imports
" where the @ dir is in 'path'
setlocal includeexpr=substitute(v:fname,'^/','','')
