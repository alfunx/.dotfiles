" vim-git - Git locations in quickfix
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/git.vim

let s:save_cpo = &cpo
set cpo&vim

" simple git blame
function! git#blame(range) abort
    return join(systemlist(printf('git -C %s blame -L %s %s',
                \ shellescape(expand('%:p:h')),
                \ a:range,
                \ shellescape(expand('%:t')))), '\n')
endfunction

" create a quickfix list with git locations
function! git#qf(...) abort
    let cmd = join(['git locations'] + a:000, ' ')
    cgetexpr system(cmd)
    call setqflist([], 'a', {'title': cmd})
endfunction

" add git locations to the current quickfix list
function! git#qfadd(...) abort
    let cmd = join(['git locations'] + a:000, ' ')
    caddexpr system(cmd)
    call setqflist([], 'a', {'title': cmd})
endfunction

" create a location list with git locations
function! git#ll(...) abort
    let cmd = join(['git locations'] + a:000, ' ')
    lgetexpr system(cmd)
    call setloclist(0, [], 'a', {'title': cmd})
endfunction

" add git locations to the location list of the current window
function! git#lladd(...) abort
    let cmd = join(['git locations'] + a:000, ' ')
    laddexpr system(cmd)
    call setloclist(0, [], 'a', {'title': cmd})
endfunction

" " GitBlame
" command! -range GBlame echo git#blame('<line1>,<line2>')
"
" " Git merge locations
" command! -bang -nargs=* -complete=file -bar GMerge
"             \ call git#qf('merge', <f-args>)
"
" " Git diff locations
" command! -bang -nargs=* -complete=file -bar GDiff
"             \ call git#qf('diff', <f-args>)
"
" " Git diff --check locations
" command! -bang -nargs=* -complete=file -bar GCheck
"             \ call git#qf('check', <f-args>)

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
