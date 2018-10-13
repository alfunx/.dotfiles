nnoremap <buffer><silent> q :q<CR>
nnoremap <buffer><silent> o <CR><C-w><C-p>
nnoremap <buffer><silent> O <CR><C-w><C-p>:q<CR>
nnoremap <buffer><silent> <CR> <CR>
"nnoremap <buffer><silent> J :cnext<CR><C-w><C-p>
"nnoremap <buffer><silent> K :cprev<CR><C-w><C-p>
nnoremap <buffer><silent> J j<CR><C-w><C-p>
nnoremap <buffer><silent> K k<CR><C-w><C-p>
nnoremap <buffer><silent> <leader><CR> <C-w><CR><C-w>L

xnoremap <buffer><silent> d :DeleteLines<cr>
nnoremap <buffer><silent> dd :DeleteLines<cr>
nnoremap <buffer><silent> u :UndoDelete<cr>

if !exists(':DeleteLines')
    let b:deletion_stack = []

    " Delete by a pattern (with undo placing them all on top):
    "
    "   :Delete ^command " Delete all entries that start with 'command'
    "   :Delete! ^command " Delete all entries that don't start with 'command'
    "
    command! -nargs=1 -bang Delete call s:Delete(<f-args>, '<bang>')
    function! s:Delete(pattern, bang)
        let saved_cursor = getpos('.')
        let deleted      = []

        let new_qflist = []
        for entry in getqflist()
            if (entry.text !~ a:pattern && a:bang == '') || (entry.text =~ a:pattern && a:bang == '!')
                call add(new_qflist, entry)
            else
                call add(deleted, entry)
            endif
        endfor

        call setqflist(new_qflist)
        if !empty(deleted)
            call insert(b:deletion_stack, [0, deleted], 0)
        endif

        call setpos('.', saved_cursor)
        echo
    endfunction

    command! -range -buffer DeleteLines call s:DeleteLines(<line1>, <line2>)
    function! s:DeleteLines(start, end)
        let saved_cursor = getpos('.')
        let start        = a:start - 1
        let end          = a:end - 1

        let qflist  = getqflist()
        let deleted = remove(qflist, start, end)
        call insert(b:deletion_stack, [start, deleted], 0)

        call setqflist(qflist)
        call setpos('.', saved_cursor)
        echo
    endfunction

    command! -buffer UndoDelete call s:UndoDelete()
    function! s:UndoDelete()
        if empty(b:deletion_stack)
            return
        endif

        let saved_cursor = getpos('.')
        let qflist       = getqflist()

        let [index, deleted] = remove(b:deletion_stack, 0)
        for line in deleted
            call insert(qflist, line, index)
            let index = index + 1
        endfor

        call setqflist(qflist)
        call setpos('.', saved_cursor)
        echo
    endfunction
end

function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

call AdjustWindowHeight(3, 10)
