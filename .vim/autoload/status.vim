" vim-status - Statusline functions
" Maintainer:	Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version:	0.1.0
" License:	MIT
" Location:	autoload/status.vim

let s:save_cpo = &cpo
set cpo&vim

" readonly
function! status#readonly() abort
    return (&readonly || !&modifiable) ? '' : ''
endfunction

" modified
function! status#modified() abort
    return &modified ? '+' : ''
endfunction

" git branch
function! status#gitbranch() abort
    if winwidth(0) < 70
        return ''
    endif
    let l:git = fugitive#head()
    return empty(l:git) ? '' : ' ' . l:git
endfunction

" trailing
function! status#trailing() abort
    let l:line = search('\s\+$', 'nw')
    return l:line ? winwidth(0) < 100 ? 'Ξ' : 'Ξ' . l:line : ''
endfunction

" mixed indent
function! status#mixedindent() abort
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
    if !&tw
        return ''
    endif
    let l:line = search('^.\{' . (&tw + 1) . ',}' , 'nw')
    return l:line ? winwidth(0) < 100 ? '→' : '→' . l:line : ''
endfunction

" syntax highlight group
function! status#syntaxhlgroup() abort
    return synIDattr(synID(line('.'), col('.'), 1), 'name')
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

let &cpo = s:save_cpo
