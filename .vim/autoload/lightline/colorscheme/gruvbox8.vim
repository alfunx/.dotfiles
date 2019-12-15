" Gruvbox8 colorscheme for Lightline
" Maintainer: Alphonse Mariya <alphonse.mariya@hotmail.com>
" Version: 0.1.0
" License: MIT
" Location: autoload/lighline/colorscheme/gruvbox8.vim
"
" See: https://github.com/morhetz/gruvbox

if exists('g:lightline')

  let s:bg0  = ['#282828', 235]
  let s:bg1  = ['#3c3836', 237]
  let s:bg2  = ['#504945', 239]
  let s:bg3  = ['#665c54', 241]
  let s:bg4  = ['#7c6f64', 243]
  let s:fg0  = ['#fbf1c7', 229]
  let s:fg1  = ['#ebdbb2', 223]
  let s:fg2  = ['#d5c4a1', 250]
  let s:fg3  = ['#bdae93', 248]
  let s:fg4  = ['#a89984', 246]

  let s:red    = ['#fb4934', 167]
  let s:green  = ['#b8bb26', 142]
  let s:yellow = ['#fabd2f', 214]
  let s:blue   = ['#83a598', 109]
  let s:purple = ['#d3869b', 175]
  let s:aqua   = ['#8ec07c', 108]
  let s:orange = ['#fe8019', 208]

  let s:p = {
        \ 'normal': {},
        \ 'inactive': {},
        \ 'insert': {},
        \ 'replace': {},
        \ 'visual': {},
        \ 'tabline': {},
        \ 'terminal': {} }

  let s:p.normal.left = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.normal.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.normal.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.inactive.right = [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
  let s:p.inactive.left =  [ [ s:bg4, s:bg1 ], [ s:bg4, s:bg1 ] ]
  let s:p.inactive.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.insert.left = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.insert.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.insert.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.terminal.left = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.terminal.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.terminal.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.replace.left = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.replace.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.replace.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.visual.left = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.visual.right = [ [ s:bg0, s:fg4 ], [ s:fg4, s:bg2 ] ]
  let s:p.visual.middle = [ [ s:bg4, s:bg1 ] ]
  let s:p.tabline.left = [ [ s:bg4, s:bg1 ] ]
  let s:p.tabline.tabsel = [ [ s:bg0, s:fg4 ] ]
  let s:p.tabline.middle = [ [ s:bg0, s:bg1 ] ]
  let s:p.tabline.right = [ [ s:fg4, s:bg2 ], [ s:bg4, s:bg1 ] ]
  let s:p.normal.error = [ [ s:bg0, s:red ] ]
  let s:p.normal.warning = [ [ s:bg0, s:yellow ] ]
  let s:p.normal.info = [ [ s:bg0, s:blue ] ]
  let s:p.normal.hint = [ [ s:bg0, s:purple ] ]

  let g:lightline#colorscheme#gruvbox8#palette = lightline#colorscheme#flatten(s:p)

endif
