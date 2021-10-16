" lightline-lsp
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/lsp.vim

let s:save_cpo = &cpo
set cpo&vim

function! lsp#errors() abort
    let cnt = luaeval("vim.lsp.diagnostic.get_count(0, [[Error]])")
    return cnt > 0 ? cnt : ''
endfunction

function! lsp#warnings() abort
    let cnt = luaeval("vim.lsp.diagnostic.get_count(0, [[Warning]])")
    return cnt > 0 ? cnt : ''
endfunction

function! lsp#infos() abort
    let cnt = luaeval("vim.lsp.diagnostic.get_count(0, [[Information]])")
    return cnt > 0 ? cnt : ''
endfunction

function! lsp#hints() abort
    let cnt = luaeval("vim.lsp.diagnostic.get_count(0, [[Hint]])")
    return cnt > 0 ? cnt : ''
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
