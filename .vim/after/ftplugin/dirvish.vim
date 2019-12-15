nmap <buffer> <Left>     -
nmap <buffer> <Right>    <CR>
nnoremap <buffer> <Up>   k
nnoremap <buffer> <Down> j

nnoremap <silent><buffer> gh :silent keeppatterns g@/\.[^/]\+/\?$@d _<CR>:setl cole=3<CR>
nnoremap <silent><buffer> gx :set conceallevel=2<CR>

nmap <buffer> q <Plug>(dirvish_quit)

" sort ,^\(.*[/]\)\|\ze,
" silent! keeppatterns g@/\.[^/]\+/\?$@d _
