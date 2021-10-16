nmap     <buffer> <Left>  -
nmap     <buffer> <Right> <CR>
nnoremap <buffer> <Up>    k
nnoremap <buffer> <Down>  j

nnoremap <buffer><silent> gh :<C-u>keeppatterns g@/\.[^/]\+/\?$@d _<CR>:setl conceallevel=3<CR>
nnoremap <buffer><silent> gx :<C-u>setl conceallevel=0<CR>
nnoremap <buffer><silent> gr :<C-u>Dirvish %<CR>

nmap <buffer> q <Plug>(dirvish_quit)

" sort ,^\(.*[/]\)\|\ze,
" silent! keeppatterns g@/\.[^/]\+/\?$@d _
