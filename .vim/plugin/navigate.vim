" Functions for navigating to files

" Edit file under cursor searching in '**' instead of 'path'
function! s:EditCursorFile()
    let file = findfile(expand('<cfile>'), '**')
    execute 'e ' . file
endfunction

nnoremap <unique> <script> <Plug>NavigateEditCursor <SID>EditCursorFile
nnoremap <SID>EditCursorFile :call <SID>EditCursorFile()<cr>
