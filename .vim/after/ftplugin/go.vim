setlocal textwidth=100
setlocal tabstop=4
setlocal formatprg=gofmt

if exists(":GoDef")
    nnoremap <buffer> <leader>] :GoDef<cr>
endif
