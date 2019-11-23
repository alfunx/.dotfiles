" vim-functions - Custom helper functions
" Maintainer:	Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version:	0.1.0
" License:	MIT
" Location:	autoload/functions.vim

" syntax highlight group
function! functions#syntax(...) abort
    let l:syn_id = synID(line('.'), col('.'), 1)
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
    return join(systemlist(join([
                \ 'git -C',
                \ shellescape(expand('%:p:h')),
                \ 'blame -L',
                \ a:range,
                \ shellescape(expand('%:t'))])), "\n")
endfunction

" run macro on visual selection
function! functions#visual_macro(type, ...)
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
function! functions#fix_space_tabstop(type, ...)
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
function! functions#send_to_tmux_split(type, ...)
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

" complete snippets
function! functions#ulti_complete() abort
    if empty(UltiSnips#SnippetsInCurrentScope(1))
        return ''
    endif

    let word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
    let contain_word = 'stridx(v:val, word_to_complete)>=0'
    let candidates = map(filter(keys(g:current_ulti_dict_info), contain_word),
                   \  "{
                   \      'word': v:val,
                   \      'menu': '[snip] '. g:current_ulti_dict_info[v:val]['description'],
                   \      'dup' : 1,
                   \   }")
    let from_where = col('.') - len(word_to_complete)

    if !empty(candidates)
        call complete(from_where, candidates)
    endif

    return ''
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

    let l:completion = v:completed_item.word
    let l:len = len(l:completion)
    let l:col = col('.') - 2
    let l:line = getline('.')

    " remove completion before expanding snippet
    call setline('.', l:line[: l:col - l:len] . l:line[l:col + 1 :])
    call cursor('.', l:col - l:len + 2)

    " expand snippet
    call UltiSnips#Anon(l:completion)

    return ''
endfunction
