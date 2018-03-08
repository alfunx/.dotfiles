"autocmd BufWinEnter <buffer> wincmd L
nnoremap <buffer><silent> q :q<CR>
nnoremap <buffer><silent> <CR> <C-]>
nnoremap <buffer><silent> <BS> <C-t>
nnoremap <buffer><silent> o /'\l\{2,\}'<CR>:nohlsearch<CR>
nnoremap <buffer><silent> O ?'\l\{2,\}'<CR>:nohlsearch<CR>
nnoremap <buffer><silent> s /\|\zs\S\+\ze\|<CR>:nohlsearch<CR>
nnoremap <buffer><silent> S ?\|\zs\S\+\ze\|<CR>:nohlsearch<CR>
