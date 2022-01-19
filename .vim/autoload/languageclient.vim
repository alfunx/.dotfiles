" lightline-languageclient
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/languageclient.vim
" Website: https://github.com/alfunx/vim-lightline-languageclient

let s:save_cpo = &cpo
set cpo&vim

function! languageclient#error() abort
    let cnt = get(LanguageClient#statusLineDiagnosticsCounts(), 'E', 0)
    return cnt > 0 ? cnt : ''
endfunction

function! languageclient#warn() abort
    let cnt = get(LanguageClient#statusLineDiagnosticsCounts(), 'W', 0)
    return cnt > 0 ? cnt : ''
endfunction

function! languageclient#info() abort
    let cnt = get(LanguageClient#statusLineDiagnosticsCounts(), 'I', 0)
    return cnt > 0 ? cnt : ''
endfunction

function! languageclient#hint() abort
    let cnt = get(LanguageClient#statusLineDiagnosticsCounts(), 'H', 0)
    return cnt > 0 ? cnt : ''
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
