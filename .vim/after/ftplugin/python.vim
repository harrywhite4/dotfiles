setlocal textwidth=100

let &l:define='^\s*\(def\|async def\|class\)'

if executable("black")
    setlocal formatprg=black\ --quiet\ -
elseif executable("autopep8")
    setlocal formatprg=autopep8\ -
endif

command! -buffer -nargs=+ Pydoc terminal ++close pipenv run python -m pydoc <args>

map <buffer> <leader>yi <Plug>PyimportCopyPath
