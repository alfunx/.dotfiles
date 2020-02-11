nmap     <buffer> <Left>  -
nmap     <buffer> <Right> <CR>
nnoremap <buffer> <Up>    k
nnoremap <buffer> <Down>  j

nnoremap <silent><buffer> gh :<C-u>keepp g@/\.[^/]\+/\?$@d _<CR>:setl conceallevel=3<CR>
nnoremap <silent><buffer> gx :<C-u>setl conceallevel=2<CR>

nmap <buffer> q <Plug>(dirvish_quit)

" sort ,^\(.*[/]\)\|\ze,
" silent! keeppatterns g@/\.[^/]\+/\?$@d _
