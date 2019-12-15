" vim-status - Statusline functions
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/status.vim

let s:save_cpo = &cpo
set cpo&vim

" fileinfo
function! status#fileinfo() abort
    let l:text = status#readonly() . status#modified()
    return empty(l:text) ? '' : ' ' . l:text
endfunction

" readonly
function! status#readonly() abort
    if getwininfo(win_getid())[0].quickfix | return '' | endif
    return (&readonly || !&modifiable) ? '' : ''
endfunction

" modified
function! status#modified() abort
    if getwininfo(win_getid())[0].quickfix | return '' | endif
    return &modified ? '+' : ''
endfunction

" git branch
function! status#gitbranch() abort
    if getwininfo(win_getid())[0].quickfix | return '' | endif
    if winwidth(0) < 70 | return '' | endif
    let l:git = fugitive#head()
    return empty(l:git) ? '' : ' ' . l:git
endfunction

" trailing
function! status#trailing() abort
    if getwininfo(win_getid())[0].quickfix | return '' | endif
    let l:line = search('\\\@1<!\s\+$', 'nw')
    return l:line ? winwidth(0) < 100 ? 'Ξ' : 'Ξ' . l:line : ''
endfunction

" mixed indent
function! status#mixedindent() abort
    if getwininfo(win_getid())[0].quickfix | return '' | endif
    let l:tabs = search('^\t', 'nw')
    let l:spaces = search('^ ', 'nw')
    if l:tabs && l:spaces
        return winwidth(0) < 100 ? '⇄' : l:tabs . '⇄' . l:spaces
    elseif l:spaces && !&et
        return winwidth(0) < 100 ? '›' : '›' . l:spaces
    elseif l:tabs && &et
        return winwidth(0) < 100 ? '~' : '~' . l:tabs
    endif
    return ''
endfunction

" long lines
function! status#longline() abort
    if getwininfo(win_getid())[0].quickfix | return '' | endif
    if !&tw | return '' | endif
    let l:line = search('^.\{' . (&tw + 1) . ',}' , 'nw')
    return l:line ? winwidth(0) < 100 ? '→' : '→' . l:line : ''
endfunction

" syntax highlight group
function! status#syntaxhlgroup() abort
    return synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction

" quickfix / locallist name
function! status#qfname()
    return get(w:, 'quickfix_title', '')
endfunction

" word count
function! status#wordcount()
    if index(['asciidoc', 'help', 'mail', 'markdown', 'org', 'rst', 'tex', 'text'], &ft) < 0
        return ''
    endif
    let l:wc = get(wordcount(), 'visual_words', 0)
    if !l:wc
        let l:wc = get(wordcount(), 'words', 0)
    endif
    return l:wc == 1 ? l:wc . ' word' : l:wc . ' words'
endfunction

" relative path
function! status#relativepath()
    if getwininfo(win_getid())[0].loclist  | return '[Location List]' | endif
    if getwininfo(win_getid())[0].quickfix | return '[Quickfix List]' | endif
    if &ft == 'fzf' | return '[FZF]' | endif
    return expand('%:p:~:.:s?^$?./?')
endfunction

" tab readonly
function! status#tab_readonly(n) abort
    let l:winnr = tabpagewinnr(a:n)
    return (gettabwinvar(a:n, l:winnr, '&readonly') ||
                \ !gettabwinvar(a:n, l:winnr, '&modifiable')) ? '' : ''
endfunction

" tab modified
function! status#tab_modified(n) abort
    let winnr = tabpagewinnr(a:n)
    return gettabwinvar(a:n, winnr, '&modified') ? '+' : ''
endfunction

" tab tabnum
let s:num={'0':'⁰','1':'¹','2':'²','3':'³','4':'⁴','5':'⁵','6':'⁶','7':'⁷','8':'⁸','9':'⁹'}
function! status#tab_tabnum(n) abort
    return join(map(split(a:n, '\zs'), 'get(s:num, v:val, "")'), '')
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
