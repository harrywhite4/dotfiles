" Get path to pipenv virtualenv
function! s:getEnvPath()
    if executable("pipenv")
        silent let output = system("pipenv --venv")
        let envpath = trim(output, "\n")
        " If command exited with 0 we got an env dir
        if v:shell_error == 0
            return envpath
        else
            echo "No venv found"
        endif
    else
        echo "Pipenv is not installed"
    endif

    return ""
endfunction

function! s:getSitePath()
    let envpath = s:getEnvPath()
    if envpath != ""
        return finddir("site-packages", envpath . "/**/")
    endif

    return ""
endfunction

" Open package from pipenv path
function! PipenvOpen(package)
    let sitepath = s:getSitePath()
    if sitepath != ""
        let package_path = sitepath . "/" . a:package
        if isdirectory(package_path)
            echo package_path
            execute "tabe" package_path
        else
            echo a:package "is not installed"
        endif
    endif
endfunction
