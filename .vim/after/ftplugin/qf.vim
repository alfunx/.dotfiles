setlocal number
setlocal nocursorline
setlocal signcolumn=no

nnoremap <buffer><silent> q :q<CR>
nnoremap <buffer><silent> <CR> <CR>
nnoremap <buffer><silent> <M-j> j<CR><C-w>p
nnoremap <buffer><silent> <M-k> k<CR><C-w>p

"nnoremap <buffer><silent> U :Restore<CR>
"nnoremap <buffer><silent> u :Restore<CR>
"nnoremap <buffer>         K :Keep<space>
"nnoremap <buffer>         R :Reject<space>
"nnoremap <buffer>         D :Reject<space>

nnoremap <buffer><silent> u     :call qf#older()<CR>
nnoremap <buffer><silent> <C-r> :call qf#newer()<CR>

"nmap <buffer> <C-Left>  <Plug>(qf_older)
"nmap <buffer> <C-Right> <Plug>(qf_newer)
"nmap <buffer> <C-Up>    <Plug>(qf_previous_file)
"nmap <buffer> <C-Down>  <Plug>(qf_next_file)

nnoremap <buffer><silent> dd :Delete!<CR>
nnoremap <buffer><silent> D  :Delete<CR>
xnoremap <buffer><silent> d  :Delete!<CR>
xnoremap <buffer><silent> D  :Delete<CR>

nnoremap <buffer><silent> df :DeleteFile!<CR>
nnoremap <buffer><silent> dF :DeleteFile<CR>
nnoremap <buffer><silent> de :DeleteExcept!<CR>
nnoremap <buffer><silent> dE :DeleteExcept<CR>

" Keep matching quickfix/loclist entries
command! -bang -nargs=1 -complete=file -bar -buffer Keep
            \ call qf#keep(<bang>0, <q-args>)

" Keep matching quickfix/loclist entries (file name only)
command! -bang -nargs=1 -complete=file -bar -buffer KeepFile
            \ call qf#keep_file(<bang>0, <q-args>)

" Keep matching quickfix/loclist entries (text only)
command! -bang -nargs=1 -complete=file -bar -buffer KeepText
            \ call qf#keep_text(<bang>0, <q-args>)

" Reject matching quickfix/loclist entries
command! -bang -nargs=1 -complete=file -bar -buffer Reject
            \ call qf#reject(<bang>0, <q-args>)

" Reject matching quickfix/loclist entries (file name only)
command! -bang -nargs=1 -complete=file -bar -buffer RejectFile
            \ call qf#reject_file(<bang>0, <q-args>)

" Reject matching quickfix/loclist entries (text only)
command! -bang -nargs=1 -complete=file -bar -buffer RejectText
            \ call qf#reject_text(<bang>0, <q-args>)

" Delete quickfix/loclist entries
command! -bang -range -bar -buffer Delete
            \ <line1>,<line2>call qf#delete(<bang>0)

" Delete quickfix/loclist entries with same filename
command! -bang -range -bar -buffer DeleteFile
            \ <line1>,<line2>call qf#delete_file(<bang>0)

" Delete quickfix/loclist entries except same filename
command! -bang -range -bar -buffer DeleteExcept
            \ <line1>,<line2>call qf#delete_except(<bang>0)

" Store quickfix/loclist entries in a file
command! -bang -nargs=1 -complete=file -bar -buffer Write
            \ call qf#write(<q-args>)

" Load quickfix/loclist entries from a file
command! -bang -nargs=1 -complete=file -bar -buffer Read
            \ call qf#read(<q-args>)
