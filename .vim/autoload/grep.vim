" vim-grep - Instant grep + quickfix
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/grep.vim
"
" See: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3

let s:save_cpo = &cpo
set cpo&vim

" create a quickfix list with search results
function! grep#qf(...) abort
    let cmd = printf('%s %s', &grepprg, join(a:000))
    cgetexpr system(cmd)
    call setqflist([], 'a', {'title': cmd})
endfunction

" add search results to the current quickfix list
function! grep#qfadd(...) abort
    let cmd = printf('%s %s', &grepprg, join(a:000))
    caddexpr system(cmd)
    call setqflist([], 'a', {'title': cmd})
endfunction

" create a location list with search results
function! grep#ll(...) abort
    let cmd = printf('%s %s', &grepprg, join(a:000))
    lgetexpr system(cmd)
    call setloclist(0, [], 'a', {'title': cmd})
endfunction

" add search results to the location list of the current window
function! grep#lladd(...) abort
    let cmd = printf('%s %s', &grepprg, join(a:000))
    laddexpr system(cmd)
    call setloclist(0, [], 'a', {'title': cmd})
endfunction

" opfunc skeleton
function! s:opfunc(fn, type, visual) abort
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:visual
        silent exe "normal! gvy"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    call function(a:fn)(shellescape(@@))

    let &selection = sel_save
    let @@ = reg_save
endfunction

" opfunc to create a quickfix list with search results
function! grep#qf_opfunc(type, ...) abort
    call s:opfunc('grep#qf', a:type, a:0)
endfunction

" opfunc to add search results to the current quickfix list
function! grep#qfadd_opfunc(type, ...) abort
    call s:opfunc('grep#qfadd', a:type, a:0)
endfunction

" opfunc to create a location list with search results
function! grep#ll_opfunc(type, ...) abort
    call s:opfunc('grep#ll', a:type, a:0)
endfunction

" opfunc to add search results to the location list of the current window
function! grep#lladd_opfunc(type, ...) abort
    call s:opfunc('grep#lladd', a:type, a:0)
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
