" vim-map - Map functions to keybindings
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/map.vim
"
" See: https://github.com/tpope/vim-unimpaired

let s:save_cpo = &cpo
set cpo&vim

function! s:do_action(fn, type)
    " backup settings that we will change
    let sel_save = &selection
    let cbd_save = &clipboard
    " make selection and clipboard work the way we need
    set selection=inclusive clipboard-=unnamed clipboard-=unnamedplus
    " backup the unnamed register, which we will be yanking into
    let reg_save = @@
    " yank the relevant text, and also set the visual selection (which will be reused if the text
    " needs to be replaced)
    if a:type =~ '^\d\+$'
        " if type is a number, then select that many lines
        silent exe 'normal! V'.a:type.'$y'
    elseif a:type =~ '^.$'
        " if type is 'v', 'V', or '<C-V>' (i.e. 0x16) then reselect the visual region
        silent exe "normal! `<" . a:type . "`>y"
    elseif a:type == 'line'
        " line-based text motion
        silent exe "normal! '[V']y"
    elseif a:type == 'block'
        " block-based text motion
        silent exe "normal! `[\<C-V>`]y"
    else
        " char-based text motion
        silent exe "normal! `[v`]y"
    endif
    " call the user-defined function, passing it the contents of the unnamed register
    let repl = function(a:fn)(@@)
    " if the function returned a value, then replace the text
    if type(repl) == 1
        " put the replacement text into the unnamed register, and also set it to be a
        " characterwise, linewise, or blockwise selection, based upon the selection type of the
        " yank we did above
        call setreg('@', repl, getregtype('@'))
        " relect the visual region and paste
        normal! gvp
    endif
    " restore saved settings and register value
    let @@ = reg_save
    let &selection = sel_save
    let &clipboard = cbd_save
endfunction

function! s:action_opfunc(type)
    return s:do_action(s:encode_algorithm, a:type)
endfunction

function! s:action_setup(fn)
    let s:encode_algorithm = a:fn
    let &opfunc = matchstr(expand('<sfile>'), '<SNR>\d\+_').'action_opfunc'
endfunction

function! map#action(fn, key)
    exe 'nnoremap <silent> <Plug>actions'    .a:fn.' :<C-U>call <SID>action_setup("'.a:fn.'")<CR>g@'
    exe 'xnoremap <silent> <Plug>actions'    .a:fn.' :<C-U>call <SID>do_action("'.a:fn.'",visualmode())<CR>'
    exe 'nnoremap <silent> <Plug>actionsLine'.a:fn.' :<C-U>call <SID>do_action("'.a:fn.'",v:count1)<CR>'
    exe 'nmap '.a:key.'                        <Plug>actions'.a:fn
    exe 'xmap '.a:key.'                        <Plug>actions'.a:fn
    exe 'nmap '.a:key.a:key[strlen(a:key)-1].' <Plug>actionsLine'.a:fn
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
