" autocmd BufWinEnter <buffer> wincmd L
nnoremap <buffer> <CR> <C-]>
nnoremap <buffer> <BS> <C-t>
nnoremap <buffer> o /'\l\{2,\}'<CR>:nohlsearch<CR>
nnoremap <buffer> O ?'\l\{2,\}'<CR>:nohlsearch<CR>
nnoremap <buffer> s /\|\zs\S\+\ze\|<CR>:nohlsearch<CR>
nnoremap <buffer> S ?\|\zs\S\+\ze\|<CR>:nohlsearch<CR>
