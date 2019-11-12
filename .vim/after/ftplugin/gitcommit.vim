nnoremap <buffer><silent> { :call search('^@@', 'bWz')<CR>zt
nnoremap <buffer><silent> } :call search('^@@', 'Wz')<CR>zt
"nnoremap <buffer><silent> <M-k> :call search('^@@', 'bWz')<CR>zt
"nnoremap <buffer><silent> <M-j> :call search('^@@', 'Wz')<CR>zt

setlocal iskeyword+=-
setlocal spell

setlocal formatoptions+=qn
setlocal formatlistpat=^\\s*[-*0-9]\\+[\]:.)}\\t\ ]\\s*
