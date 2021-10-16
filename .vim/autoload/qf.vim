" vim-filter - Filter quickfix
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/filter.vim
"
" See: https://gist.github.com/PeterRincker/33345cf7fdeb9038611e4a338a0067f3

let s:save_cpo = &cpo
set cpo&vim

function! s:is_location()
    let wininfo = filter(getwininfo(), {i, v -> v.winnr == winnr()})[0]
    return wininfo.loclist
endfunction

function! s:get_property(key, ...)
    let l:what = {a:key: a:0 ? a:1 : 0}
    let l:listdict = s:is_location() ? getloclist(0, l:what) : getqflist(l:what)
    return get(l:listdict, a:key)
endfunction

function! s:get_list()
    return s:is_location() ? getloclist(0) : getqflist()
endfunction

function! s:set_list(...)
    return s:is_location() ? call('setloclist', [0] + a:000) : call('setqflist', a:000)
endfunction

function! s:length()
    return s:get_property('size')
endfunction

function! s:is_first()
    return s:get_property('nr') <= 1
endfunction

function! s:is_last()
    return s:get_property('nr') == s:get_property('nr', '$')
endfunction

function! s:history(newer)
    let save_pos = getcurpos()

    let cmd = (s:is_location() ? 'l' : 'c') . (a:newer ? 'newer' : 'older')
    let last = s:get_property('nr', '$')

    let current = s:get_property('nr')
    while (a:newer && current < last) || (!a:newer && current > 1)
        silent execute cmd
        let current = s:get_property('nr')
        if s:get_property('size') | break | endif
    endwhile

    echo 'List ' . current . ' of ' . last
                \ . ', ' . s:get_property('size') . ' items'

    call setpos('.', save_pos)
endfunction

function! qf#older()
    call s:history(0)
endfunction

function! qf#newer()
    call s:history(1)
endfunction

function! s:filter(bang, search, condition, ...)
    let save_pos = getcurpos()

    if a:search[0] == a:search[-1:] && count("/\"'", a:search[0])
        let pattern = a:search[1:-2]
        if pattern == '' | let pattern = @/ | endif
    else
        let pattern = a:search
    endif
    if pattern == '' | return | endif

    let description = a:0 ? a:1 : 'F'
    let title = s:get_property('title', 1) . (a:bang ? '' : ' | ' . description . ': ' . pattern)
    let entries = s:get_list()
    call filter(entries, a:condition)
    call s:set_list([], a:bang ? 'r' : ' ', {'title': title, 'items': entries})

    echo description . ' ' . pattern
                \ . ', ' . len(entries) .' items'

    call setpos('.', save_pos)
endfunction

function! qf#keep(bang, pattern)
    call s:filter(a:bang, a:pattern, 'v:val.text =~# pattern || bufname(v:val.bufnr) =~# pattern || v:val.module =~# pattern', 'K')
endfunction

function! qf#keep_file(bang, pattern)
    call s:filter(a:bang, a:pattern, 'bufname(v:val.bufnr) =~# pattern || v:val.module =~# pattern', 'KF')
endfunction

function! qf#keep_text(bang, pattern)
    call s:filter(a:bang, a:pattern, 'v:val.text =~# pattern', 'KT')
endfunction

function! qf#reject(bang, pattern)
    call s:filter(a:bang, a:pattern, 'v:val.text !~# pattern && bufname(v:val.bufnr) !~# pattern && v:val.module !~# pattern', 'R')
endfunction

function! qf#reject_file(bang, pattern)
    call s:filter(a:bang, a:pattern, 'bufname(v:val.bufnr) !~# pattern && v:val.module !~# pattern', 'RF')
endfunction

function! qf#reject_text(bang, pattern)
    call s:filter(a:bang, a:pattern, 'v:val.text !~# pattern', 'RT')
endfunction

function! qf#delete(bang) range
    let save_pos = getcurpos()

    let title = s:get_property('title') . (a:bang ? '' : ' | D')
    let entries = s:get_list()
    if !len(entries) | return | endif
    call remove(entries, a:firstline - 1, a:lastline - 1)
    call s:set_list([], a:bang ? 'r' : ' ', {'title': title, 'items': entries})
    let cnt = a:lastline - a:firstline + 1

    echo 'Delete ' . cnt . (cnt > 1 ? ' items' : ' item')
                \ . ', ' . len(entries) .' items'

    call setpos('.', save_pos)
endfunction

function! qf#delete_file(bang)
    let entries = s:get_list()
    let file = bufname(get(get(entries, line('.') - 1, {}), 'bufnr', ''))
    call qf#reject_file(a:bang, file)
endfunction

function! qf#delete_except(bang)
    let entries = s:get_list()
    let file = bufname(get(get(entries, line('.') - 1, {}), 'bufnr', ''))
    call qf#keep_file(a:bang, file)
endfunction

function! qf#add_entry(...)
    let text = a:0 ? a:1 : getline('.')
    let SetList = a:0 > 1 ? function('setloclist', [0]) : function('setqflist')
    let title = get(a:0 > 1 ? getloclist(0, {'title': 0}) : getqflist({'title': 0}), 'title')
    let entry = {'bufnr': bufnr(), 'lnum': line('.'), 'col': col('.'), 'text': text}
    call SetList([], 'a', {'title': title, 'items': [entry]})
endfunction

function! qf#write(file)
    let entries = s:get_list()
    let lines = map(entries, 'join([bufname(v:val.bufnr), v:val.lnum, v:val.col, v:val.text], ":")')
    call writefile(lines, a:file)
endfunction

function! qf#read(file)
    let cmd = s:is_location() ? 'lgetfile' : 'cgetfile'
    execute join([cmd, a:file])
    call s:set_list([], 'a', {'title': 'Read: ' . a:file})
endfunction

" " Keep matching quickfix/loclist entries
" command! -bang -nargs=1 -complete=file -bar -buffer Keep
"             \ call qf#keep(<bang>0, <q-args>)
"
" " Keep matching quickfix/loclist entries (file name only)
" command! -bang -nargs=1 -complete=file -bar -buffer KeepFile
"             \ call qf#keep_file(<bang>0, <q-args>)
"
" " Keep matching quickfix/loclist entries (text only)
" command! -bang -nargs=1 -complete=file -bar -buffer KeepText
"             \ call qf#keep_text(<bang>0, <q-args>)
"
" " Reject matching quickfix/loclist entries
" command! -bang -nargs=1 -complete=file -bar -buffer Reject
"             \ call qf#reject(<bang>0, <q-args>)
"
" " Reject matching quickfix/loclist entries (file name only)
" command! -bang -nargs=1 -complete=file -bar -buffer RejectFile
"             \ call qf#reject_file(<bang>0, <q-args>)
"
" " Reject matching quickfix/loclist entries (text only)
" command! -bang -nargs=1 -complete=file -bar -buffer RejectText
"             \ call qf#reject_text(<bang>0, <q-args>)
"
" " Delete quickfix/loclist entries
" command! -bang -range -bar -buffer Delete
"             \ <line1>,<line2>call qf#delete(<bang>0)
"
" " Delete quickfix/loclist entries with same filename
" command! -bang -range -bar -buffer DeleteFile
"             \ <line1>,<line2>call qf#delete_file(<bang>0)
"
" " Delete quickfix/loclist entries except same filename
" command! -bang -range -bar -buffer DeleteExcept
"             \ <line1>,<line2>call qf#delete_except(<bang>0)
"
" " Store quickfix/loclist entries in a file
" command! -bang -nargs=1 -complete=file -bar -buffer Write
"             \ call qf#write(<q-args>)
"
" " Load quickfix/loclist entries from a file
" command! -bang -nargs=1 -complete=file -bar -buffer Read
"             \ call qf#read(<q-args>)

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
