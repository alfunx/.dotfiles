" lightline-diagnostic
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/diagnostic.vim

let s:save_cpo = &cpo
set cpo&vim

function! diagnostic#error() abort
    let cnt = luaeval("#(vim.diagnostic.get(0, {severity=vim.diagnostic.severity.ERROR}))")
    return cnt > 0 ? cnt : ''
endfunction

function! diagnostic#warn() abort
    let cnt = luaeval("#(vim.diagnostic.get(0, {severity=vim.diagnostic.severity.WARN}))")
    return cnt > 0 ? cnt : ''
endfunction

function! diagnostic#info() abort
    let cnt = luaeval("#(vim.diagnostic.get(0, {severity=vim.diagnostic.severity.INFO}))")
    return cnt > 0 ? cnt : ''
endfunction

function! diagnostic#hint() abort
    let cnt = luaeval("#(vim.diagnostic.get(0, {severity=vim.diagnostic.severity.HINT}))")
    return cnt > 0 ? cnt : ''
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
