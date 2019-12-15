" vim-functions - Custom helper functions
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/functions.vim

let s:save_cpo = &cpo
set cpo&vim

" OS related variable
let s:is_win = has('win32') || has('win64')
let s:is_mac = !s:is_win && (has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin')
let s:is_linux = !s:is_win && !s:is_mac
let s:open = s:is_win ? 'start' : s:is_mac ? 'open' : 'xdg-open'

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

" change register
function! functions#change_register() abort
    let x = nr2char(getchar())
    call feedkeys(":let @" . x . " = \<C-r>\<C-r>=string(@" . x . ")\<CR>\<Left>", 'n')
endfunction

" simple git blame
function! functions#gitblame(range) abort
    return join(systemlist(printf('git -C %s blame -L %s %s',
                \ shellescape(expand('%:p:h')),
                \ a:range,
                \ shellescape(expand('%:t')))), '\n')
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
    call setline('.', line[: col - len] . line[col + 1 :])
    call cursor('.', col - len + 2)

    " expand snippet
    call UltiSnips#Anon(completion)

    return ''
endfunction

" pretty fold text
function! functions#foldtext()
    let line = printf('  %s  ', substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g'))
    let linecount = printf('┤ %4d ├', v:foldend - v:foldstart + 1)
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
    call system(s:open . ' "' . escape(url, '"') . '"')
    return s:open . ' ' . escape(url, '"')
endfunction

" open floating window with borders
function! functions#nvim_open_window(buffer, enter, opts)
    if get(a:opts, 'border', v:false)
        call remove(a:opts, 'border')
        let opts = copy(a:opts)
        let opts.width += 4
        let opts.height += 2
        let opts.row -= 1
        let opts.col -= 2
        let opts.focusable = v:false
        let opts.style = 'minimal'
        let frame =            [ '╭' . repeat('─', opts.width - 2) . '╮' ]
                    \ + repeat([ '│' . repeat(' ', opts.width - 2) . '│' ], opts.height - 2)
                    \ +        [ '╰' . repeat('─', opts.width - 2) . '╯' ]
        let s:buf = nvim_create_buf(v:false, v:true)
        call nvim_buf_set_lines(s:buf, 0, -1, v:true, frame)
        let border = nvim_open_win(s:buf, v:true, opts)
        call setwinvar(border, '&winhl', 'NormalFloat:Comment')
        let win = nvim_open_win(a:buffer, a:enter, a:opts)
        autocmd BufWipeout <buffer> exe 'bw ' . s:buf
        return win
    else
        return nvim_open_win(a:buffer, a:enter, a:opts)
    endif
endfunction

let &cpo = s:save_cpo

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
