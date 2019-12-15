" vim-completion - Custom completion functions
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/completion.vim

" complete snippets
function! completion#ultisnips() abort
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

" complete with text from tmux panes
function! completion#tmux() abort
    let word_to_complete = matchstr(strpart(getline('.'), 0, col('.') - 1), '\S\+$')
    let candidates = tmuxcomplete#complete(0, word_to_complete)
    let from_where = col('.') - len(word_to_complete)

    if !empty(candidates)
        call complete(from_where, candidates)
    endif

    return ''
endfunction
