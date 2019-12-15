nnoremap <buffer><silent> q :q<CR>
nnoremap <buffer><silent> <CR> <CR>
nnoremap <buffer><silent> <M-j> j<CR><C-w>p
nnoremap <buffer><silent> <M-k> k<CR><C-w>p

nnoremap <buffer><silent> U :Restore<CR>
nnoremap <buffer><silent> u :Restore<CR>
nnoremap <buffer>         K :Keep<space>
nnoremap <buffer>         R :Reject<space>
nnoremap <buffer>         D :Reject<space>

nmap <buffer> <C-Left>  <Plug>(qf_older)
nmap <buffer> <C-Right> <Plug>(qf_newer)
nmap <buffer> <C-Up>    <Plug>(qf_previous_file)
nmap <buffer> <C-Down>  <Plug>(qf_next_file)

setlocal number
setlocal nocursorline
setlocal signcolumn=no
