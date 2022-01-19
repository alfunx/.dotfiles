" goto tag
nnoremap <buffer><silent><nowait> <CR> <C-]>
nnoremap <buffer><silent><nowait> <BS> <C-t>

" tag definition
nnoremap <buffer><silent> <C-Up>   :call search("\\*\\S\\+\\*", 'sbW')<CR>
nnoremap <buffer><silent> <C-Down> :call search("\\*\\S\\+\\*", 'sW')<CR>

" tag reference
nnoremap <buffer><silent> <M-Up>   :call search("\|\\S\\+\|", 'sbW')<CR>
nnoremap <buffer><silent> <M-Down> :call search("\|\\S\\+\|", 'sW')<CR>

" option definition
nnoremap <buffer><silent> <C-Left>  :call search("\\*'\\l\\{2,}'\\*", 'sbW')<CR>
nnoremap <buffer><silent> <C-Right> :call search("\\*'\\l\\{2,}'\\*", 'sW')<CR>

" option reference
nnoremap <buffer><silent> <M-Left>  :call search("\\([^*]\\\|^\\)\\zs'\\l\\{2,}'\\ze\\([^*]\\\|$\\)", 'sbW')<CR>
nnoremap <buffer><silent> <M-Right> :call search("\\([^*]\\\|^\\)\\zs'\\l\\{2,}'\\ze\\([^*]\\\|$\\)", 'sW')<CR>

" edit help file
nnoremap <buffer><silent><expr> <leader>e &ft == 'help' ? ':setf text<CR>' : ':setf help<CR>'

setlocal list
setlocal listchars+=tab:\ \ 
