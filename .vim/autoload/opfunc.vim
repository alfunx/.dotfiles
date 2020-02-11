" vim-functions - Custom operator functions
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/opfunc.vim

let s:save_cpo = &cpo
set cpo&vim

" run macro on visual selection
function! opfunc#visual_macro(type, ...) abort
    if a:0
        silent exe "normal! gvV"
    elseif a:type == 'line'
        silent exe "normal! '[V']V"
    else
        silent exe "normal! `[v`]V"
    endif

    exec "'<,'>normal @" . nr2char(getchar())
endfunction

" fix space tabstop
function! opfunc#fix_space_tabstop(type, ...) abort
    if a:0
        silent exe "normal! gvV"
    elseif a:type == 'line'
        silent exe "normal! '[V']V"
    else
        silent exe "normal! `[v`]V"
    endif

    let l:ts = &tabstop
    let &tabstop = nr2char(getchar())
    set noexpandtab
    '<,'>retab!
    let &tabstop = l:ts
    set expandtab
    '<,'>retab
endfunction

" send to tmux split
function! opfunc#send_to_tmux_split(type, ...) abort
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0
        silent exe "normal! gvy"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    call VimuxOpenRunner()
    call VimuxSendText(@@)
    silent exe "normal! `v"

    let &selection = sel_save
    let @@ = reg_save
endfunction

" google it
function! opfunc#google(type, ...) abort
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0
        silent exe "normal! gvy"
    elseif a:type == 'line'
        silent exe "normal! '[V']y"
    else
        silent exe "normal! `[v`]y"
    endif

    call functions#google(@@, 0)

    let &selection = sel_save
    let @@ = reg_save
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
