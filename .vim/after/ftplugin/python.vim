setlocal textwidth=100

let &l:define='^\s*\(def\|async def\|class\)'

if executable("autopep8")
    setlocal formatprg=autopep8\ -
endif

setlocal omnifunc=jedi#completions

command! -buffer -nargs=+ Pydoc terminal ++close pipenv run python -m pydoc <args>

nnoremap <buffer> <leader>] :call jedi#goto()<cr>
nnoremap <buffer> <leader>lk :call jedi#show_documentation()<cr>
nnoremap <buffer> <leader>lr :call jedi#usages()<cr>
nnoremap <buffer> <leader>ln :call jedi#rename()<cr>

map <buffer> <leader>yi <Plug>PyimportCopyPath
