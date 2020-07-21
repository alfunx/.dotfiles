"autocmd BufWinEnter <buffer> wincmd L
nnoremap <buffer><silent> q :q<CR>
nnoremap <buffer><silent> <CR> <C-]>
nnoremap <buffer><silent> <BS> <C-t>
nnoremap <buffer><silent> o /'\l\{2,\}'<CR>:nohlsearch<CR>
nnoremap <buffer><silent> O ?'\l\{2,\}'<CR>:nohlsearch<CR>
nnoremap <buffer><silent> i /\|\zs\S\+\ze\|<CR>:nohlsearch<CR>
nnoremap <buffer><silent> I ?\|\zs\S\+\ze\|<CR>:nohlsearch<CR>

nnoremap <buffer><silent> d <C-d>
nnoremap <buffer><silent> u <C-u>
