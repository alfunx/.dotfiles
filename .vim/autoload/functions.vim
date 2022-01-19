" vim-functions - Custom helper functions
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/functions.vim

let s:save_cpo = &cpo
set cpo&vim

" OS related variables
let s:is_win = has('win32') || has('win64')
let s:is_mac = !s:is_win && (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')
let s:is_linux = !s:is_win && !s:is_mac

" open file with OS
function! functions#open(...) abort
    let open = s:is_win ? 'start ' : s:is_mac ? 'open ' : 'xdg-open '
    call system(open . shellescape(join(a:000)))
endfunction

" syntax highlight group
function! functions#syntax(...) abort
    let syn_id = synID(line('.'), col('.'), 1)
    if a:0 > 1
        return synIDattr(syn_id, a:1, a:2)
    elseif a:0 > 0
        return synIDattr(syn_id, a:1)
    else
        return synIDattr(syn_id, 'name')
    endif
endfunction

" print syntax highlight group
function! functions#echo_syntax(...) abort
    let hi = synIDattr(synID(line('.'),col('.'),1),'name')
    let tr = synIDattr(synID(line('.'),col('.'),0),'name')

    let hic = synIDattr(synIDtrans(synID(line('.'),col('.'),1)),'name')
    let trc = synIDattr(synIDtrans(synID(line('.'),col('.'),0)),'name')

    echon 'hi: '
    echohl Todo
    echon hi
    echohl None
    echon ' (' . hic . ' '
    exec  'echohl ' . hic
    echon '●'
    echohl None
    echon ')  '

    echon 'tr: '
    echohl Todo
    echon tr
    echohl None
    echon ' (' . trc . ' '
    exec  'echohl ' . tr
    echon '●'
    echohl None
    echon ')  '
endfunction

" change register
function! functions#change_register() abort
    let x = nr2char(getchar())
    call feedkeys(":let @" . x . " = \<C-r>\<C-r>=string(@" . x . ")\<CR>\<Left>", 'n')
endfunction

" use UltiSnips to expand snippet in completion
function! functions#expand_snippet() abort
    if empty(v:completed_item)
        return ''
    endif

    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res > 0
        return ''
    endif

    let completion = v:completed_item.word
    let len = len(completion)
    let col = col('.') - 2
    let line = getline('.')

    " remove completion before expanding snippet
    call setline('.', line[:col-len] . line[col+1:])
    call cursor('.', col-len+2)

    " expand snippet
    call UltiSnips#Anon(completion)

    return ''
endfunction

" pretty fold text
function! functions#foldtext() abort
    let line = printf('  %s  ', substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g'))
    let linecount = printf('┤ %5d ├', v:foldend - v:foldstart + 1)
    let foldcount = v:foldlevel > 1 ? printf('┤ %d ├', v:foldlevel) : ''
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldhead = strpart(printf('%s%s%s%s', repeat(foldchar, 3), foldcount, repeat(foldchar, 3), line), 0, (winwidth(0)*2)/3)
    let foldtail = linecount . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldhead . foldtail, '.', 'x', 'g')) + &foldcolumn
    return foldhead . repeat(foldchar, winwidth(0)-foldtextlength) . foldtail
endfunction

" trim string
function! functions#trim(text) abort
    return substitute(a:text, '\(^\|\n\).\{-}\zs\\\@1<!\s\+\ze\($\|\n\)', '', 'g')
endfunction

" convert number to bin
function! functions#bin(num) abort
    return printf('%b', a:num)
endfunction

" convert number to hex
function! functions#hex(num) abort
    return printf('%x', a:num)
endfunction

" convert number to dec
function! functions#dec(num) abort
    return printf('%d', a:num)
endfunction

" search on google
function! functions#google(query, lucky) abort
    let query = substitute(
                \ substitute(
                \ trim(a:query), '["\n]', ' ', 'g'),
                \ '[[:punct:] ]', '\=printf("%%%02X", char2nr(submatch(0)))', 'g')
    let url = printf('https://www.google.com/search?%sq="%s"', a:lucky ? 'btnI&' : '', query)
    call functions#open(url)
endfunction

" close window if it is an fzf window
function! functions#close_if_fzf() abort
    if &ft == 'fzf' | quit! | endif
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
