"============================================================================
"File:        plugin/mucfind.vim
"Description: Vim plugin to perform mu search and insert the selected result
"             This plugin has been created to be used with this great unix-style
"             mail setup by Tomka <tomka@g.o>:
"             http://dev.gentoo.org/~tomka/mail.html
"
"             Of course you can use it for any search using “mu”.
"             Please note I’m a vim-script beginner so this script can most
"             likely be improve. Any feedback is welcome.
"
"Author:      sheoak
"Version:     0.1 beta
"License:     MIT License. Copyright (c) 2014
"URL:         Coming soon
"
"Require:     mu: http://www.djcbsoftware.nl/code/mu/
"
"Todo:        Create normal mode shortcut
"             CFix regex complexity
"============================================================================

if !exists("g:mucfind_run_key")
    let g:mucfind_run_key = "<F6>"
endif

" search for given string parameter using "mu cfind" command
function! Mucfind(search)

    " run the search with mu
    " email will be enclosed with <> except if no name is attached
    " Todo: improve regex, (find out how to make \s([^\s]+)$ works)
    let l:reg    = 's/\s([-_i@\+\!\#\$\%\&\*\=\/\?\^`\{\}\~''0-9a-z\.]+)$/ <\1>/gi'
    let l:muresult = system('mu cfind ' . a:search)

    if v:shell_error
        return []
    endif

    let l:result = system('echo "' . l:muresult . '" | grep -v "^$" | sed -re ' . shellescape(l:reg))

   return split(l:result, '\n')

endfunction


function! s:MuformatResult(result)

    " generate options list, with option 0 (Prompt)
    let l:opts = ['0: Enter your choice number: ']

    " build visual user list
    let l:i = 1
    for l:opt in a:result

        call add(l:opts, l:i . ': ' . l:opt)
        let l:i += 1

    endfor

    return l:opts

endfunction


" Ask user for string to search with mu and return selected result
function! Muprompt()

    " get user search
    let l:search = input("Mu search:")

    if l:search == ""
        echom "Search cancelled"
        return ""
    endif

    " run query
    let l:result = Mucfind(l:search)
    let l:total  = len(l:result)

    if l:total == 0
        echom "No result, try again"
        return ""
    endif

    " format result with number prefix and get user choice
    let l:choice = inputlist(s:MuformatResult(l:result))

    " out of index
    if l:choice > l:total
        " Fixme : error message doesn’t echo with a \n
        echoe "Invalid Index"
        return ""
    " valid choice
    elseif l:choice > 0
        return l:result[l:choice - 1]
    " cancel (0)
    else
        return ""

endfunction

" insert mode ma
exe "inoremap " . g:mucfind_run_key . " <C-R>=Muprompt()<C-M>"





