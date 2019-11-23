"""""""""""
"  VIMRC  "
"""""""""""

if !filereadable($HOME . '/.vim/autoload/plug.vim')
    silent !mkdir -p ~/.vim/autoload >/dev/null 2>&1
    silent !mkdir -p ~/.vim/plugged >/dev/null 2>&1
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                \ >/dev/null 2>&1
    autocmd VimEnter * PlugInstall
endif


"""""""""""""
"  PLUGINS  "
"""""""""""""

call plug#begin('~/.vim/plugged')

" FZF
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/bin/fzf'

" General
Plug 'alfunx/fzf.vim'  " fork of 'junegunn/fzf.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'Konfekt/vim-CtrlXA'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-dispatch'
"Plug 'tpope/vim-commentary'
Plug 'alfunx/tcomment_vim'  " fork of 'tomtom/tcomment_vim'
Plug 'alfunx/diffconflicts'  " fork of 'whiteinge/diffconflicts'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-sneak'
Plug 'terryma/vim-multiple-cursors'
"Plug 'jiangmiao/auto-pairs'
Plug 'tmsvg/pear-tree'
Plug 'mbbill/undotree'
Plug 'ap/vim-css-color'
"Plug 'markonm/traces.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'dense-analysis/ale'
Plug 'majutsushi/tagbar'
Plug 'editorconfig/editorconfig-vim'
Plug 'romainl/vim-qf'
Plug 'sheerun/vim-polyglot'
Plug 'fszymanski/fzf-quickfix', {'on': 'Quickfix'}

" Text objects
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-after-object'
Plug 'alfunx/vim-indent-object'  " fork of 'michaeljsmith/vim-indent-object'
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'

" Tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/tmux-complete.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'alfunx/vim-snippets'  " fork of 'honza/vim-snippets'

" Language server
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'

" Language specific
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }

" Syntax
Plug 'cespare/vim-toml'
Plug 'tomlion/vim-solidity'

" Themes
Plug 'alfunx/gruvbox'  " fork of 'morhetz/gruvbox'
Plug 'lifepillar/vim-gruvbox8'

" Don't load in console
if &term !=? 'linux' || has('gui_running')
    "Plug 'vim-airline/vim-airline'
    Plug 'itchyny/lightline.vim'
endif

call plug#end()

if !has('nvim')
    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
    runtime ftplugin/man.vim
    runtime macros/matchit.vim
endif


"""""""""""
"  THEME  "
"""""""""""

augroup CursorLineHighlighting
    autocmd!
    autocmd ColorScheme * if &bg == "dark" |
                \ hi! CursorLine guibg=#32302f | hi! CursorLineNR gui=bold guibg=#32302f |
                \ else |
                \ hi! CursorLine guibg=#f2e5bc | hi! CursorLineNR gui=bold guibg=#f2e5bc |
                \ endif
augroup END

augroup QuickFixHighlighting
    autocmd!
    autocmd ColorScheme * hi! QuickFixLine gui=bold term=bold cterm=bold
    autocmd ColorScheme * hi! link qfFileName Special
augroup END

augroup MarkdownFenceHighlighting
    autocmd!
    autocmd ColorScheme * hi! link mkdCodeStart NonText
    autocmd ColorScheme * hi! link mkdCodeEnd NonText
    autocmd ColorScheme * hi! link mkdCodeDelimiter NonText
augroup END

augroup ConflictMarkerHighlighting
    autocmd!
    autocmd ColorScheme * hi! link VcsConflict Error
    autocmd BufEnter,WinEnter * match VcsConflict '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$'
augroup END

"augroup SpellBadHighlighting
"    autocmd!
"    autocmd BufEnter,WinEnter * hi! SpellBad guisp=#fb4934 gui=undercurl term=undercurl cterm=undercurl
"augroup END

augroup StatusLineUpdate
    autocmd!
    if exists(':AirlineRefresh')
        autocmd ColorScheme * :AirlineRefresh
    endif
    if exists('*lightline#colorscheme')
        autocmd ColorScheme * call lightline#colorscheme()
    endif
    if exists('*lightline#update')
        autocmd BufAdd,BufWritePost,VimResized * call lightline#update()
    endif
augroup END

" Theme and colors
set termguicolors
set background=dark
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"set t_Co=256
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
colorscheme gruvbox

" Switch cursor according to mode
if &term !=? 'linux' || has('gui_running')
    let &t_SI="\<Esc>[6 q"
    let &t_SR="\<Esc>[4 q"
    let &t_EI="\<Esc>[2 q"
    let &t_ue="\<Esc>[4:0m"
    let &t_us="\<Esc>[4:2m"
    "let &t_Ce="\<Esc>[4:0m"
    "let &t_Cs="\<Esc>[4:3m"
    let &t_Ce="\<Esc>[4:0;59m"
    let &t_Cs="\e[4:3;58;5;167m"
endif


""""""""""""""""""
"  KEY MAPPINGS  "
""""""""""""""""""

" Alt key mappings
if !has('nvim')
    exec "set <M-1>=\<Esc>1"
    exec "set <M-2>=\<Esc>2"
    exec "set <M-3>=\<Esc>3"
    exec "set <M-4>=\<Esc>4"
    exec "set <M-5>=\<Esc>5"
    exec "set <M-6>=\<Esc>6"
    exec "set <M-7>=\<Esc>7"
    exec "set <M-8>=\<Esc>8"
    exec "set <M-9>=\<Esc>9"
    exec "set <M-0>=\<Esc>0"
    exec "set <M-b>=\<Esc>b"
    exec "set <M-e>=\<Esc>e"
    exec "set <M-S-h>=\<Esc>H"
    exec "set <M-h>=\<Esc>h"
    exec "set <M-j>=\<Esc>j"
    exec "set <M-k>=\<Esc>k"
    exec "set <M-S-l>=\<Esc>L"
    exec "set <M-l>=\<Esc>l"
    exec "set <M-n>=\<Esc>n"
    exec "set <M-p>=\<Esc>p"
    exec "set <M-u>=\<Esc>u"
    exec "set <M-w>=\<Esc>w"
    exec "set <M-z>=\<Esc>z"
endif

" Leader key
nnoremap <Space> <Nop>
nnoremap <CR> <Nop>
let mapleader = ' '
let maplocalleader = ''

" Split navigation
"nnoremap <silent> <C-h> <C-w><C-h>
"nnoremap <silent> <C-j> <C-w><C-j>
"nnoremap <silent> <C-k> <C-w><C-k>
"nnoremap <silent> <C-l> <C-w><C-l>

" Split navigation (vim-tmux-navigator)
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-BS> :TmuxNavigatePrevious<CR>

" Split resize
nnoremap <silent> <C-w>h 5<C-w><
nnoremap <silent> <C-w>j 5<C-w>-
nnoremap <silent> <C-w>k 5<C-w>+
nnoremap <silent> <C-w>l 5<C-w>>

" New tab
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <silent> <C-w><C-t> :tabnew<CR>

" Tab navigation
nnoremap <silent> <C-w><C-h> gT
nnoremap <silent> <C-w><C-l> gt
nnoremap <silent> <M-S-h> gT
nnoremap <silent> <M-S-l> gt

" Fullscreen
nnoremap <silent> <C-w>F <C-w>_<C-w><Bar>

" Equal
nnoremap <silent> <C-w>0 <C-w>=

" Make Y behave like other commands
nnoremap <silent> Y y$

" Copy to system clipboard
nnoremap <silent> gy "+y
nnoremap <silent> gY "+Y
nnoremap <silent> gp "+p
nnoremap <silent> gP "+P
xnoremap <silent> gy "+y
xnoremap <silent> gY "+Y
xnoremap <silent> gp "+p
xnoremap <silent> gP "+P

" Keep selection after indenting
xnoremap <silent> < <gv
xnoremap <silent> > >gv

" Swap lines
xnoremap <silent> <leader>j :m '>+1<CR>gv=gv
xnoremap <silent> <leader>k :m '<-2<CR>gv=gv
nnoremap <silent> <leader>j :m .+1<CR>
nnoremap <silent> <leader>k :m .-2<CR>

" Use CTRL-S for saving, also in Insert mode
nnoremap <silent> <C-s>      :write<CR>
xnoremap <silent> <C-s> <Esc>:write<CR>
inoremap <silent> <C-s> <C-o>:write<CR><Esc>

" Insert mode mappings
inoremap <silent> <C-u> <C-g>u<C-u>
inoremap <silent> àà    <C-o>O
inoremap <silent> éé    <C-o>o
inoremap <silent> <M-b> <C-o>b
inoremap <silent> <M-w> <C-o>w
inoremap <silent> <M-e> <C-o>e<Right>
inoremap <silent> <M-n> <Right>
inoremap <silent> <M-p> <Left>

" Entire text-object
xnoremap <silent> ie :<C-u>normal! G$Vgg0<CR>
onoremap <silent> ie :<C-u>normal! G$Vgg0<CR>
xnoremap <silent> ae :<C-u>normal! G$Vgg0<CR>
onoremap <silent> ae :<C-u>normal! G$Vgg0<CR>

" Select last inserted text
nnoremap gV `[v`]

" Move cursor by dipslay lines when wrapping
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'

" Go to tab
nnoremap <silent> <M-1> 1gt
nnoremap <silent> <M-2> 2gt
nnoremap <silent> <M-3> 3gt
nnoremap <silent> <M-4> 4gt
nnoremap <silent> <M-5> 5gt
nnoremap <silent> <M-6> 6gt
nnoremap <silent> <M-7> 7gt
nnoremap <silent> <M-8> 8gt
nnoremap <silent> <M-9> 9gt
nnoremap <silent> <M-0> :tablast<CR>

" Wildmenu
set wildchar=<Tab>
set wildcharm=<Tab>
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? '<C-g>' : '<Tab>'
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? '<C-t>' : '<S-Tab>'

" Remove trailing whitespaces
nnoremap <silent> <F3> mz:keeppatterns %s/\\\@1<!\s\+$//e<CR>`z

" Allow saving of files as sudo
command! W exec 'silent! w !sudo /usr/bin/tee % >/dev/null' <Bar> edit!

" Set path to current file
command! -bang -nargs=* Cd cd<bang> %:p:h

" No highlight
nnoremap <silent> <M-b> :<C-u>nohlsearch<CR>

" Run last macro
nnoremap Q @@

" Run macro on visual selection
nnoremap <silent> <leader>@ :set opfunc=functions#visual_macro<CR>g@
xnoremap <silent>         @ :<C-u>call functions#visual_macro(visualmode(), 1)<CR>

" Change register
nnoremap <silent> cx :<C-u>call functions#change_register()<CR>

" Diff update
nnoremap <silent> du :diffupdate<CR>

" Scroll
map <silent> <ScrollWheelUp> <C-y>
map <silent> <ScrollWheelDown> <C-e>

" German keyboard mappings
nmap <silent> ä ^
xmap <silent> ä ^
omap <silent> ä ^
nmap <silent> ö "
xmap <silent> ö "
omap <silent> ö "

nmap <silent> ü [
xmap <silent> ü [
omap <silent> ü [
nmap <silent> ¨ ]
xmap <silent> ¨ ]
omap <silent> ¨ ]

nnoremap <silent> è <C-]>
xnoremap <silent> è <C-]>

nnoremap <silent> <CR> <C-]>
xnoremap <silent> <CR> <C-]>

nnoremap <silent> <M-j> }
xnoremap <silent> <M-j> }
onoremap <silent> <M-j> }
nnoremap <silent> <M-k> {
xnoremap <silent> <M-k> {
onoremap <silent> <M-k> {

" Copy path:line
"nnoremap <silent> <F4> :<C-u>exe "!tmux send -t " . v:count . " 'b " . expand("%:p") . ":" . line(".") . "' C-m"<CR>
"nnoremap <silent> <F4> :call system("tmux send -t monetDB:server 'b " . expand("%:p") . ":" . line(".") . "' C-m")<CR>
nnoremap <silent> <F4> :<C-u>let @+ = expand("%:p") . ":" . line(".")<CR>

" Display highlighting info
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" RG
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ 'rg --hidden --line-number --column --no-heading --smart-case --follow --color=always --colors="match:none" --colors="path:fg:white" --colors="line:fg:white" '.shellescape(<q-args>), 1,
            \ <bang>0)

" AG
command! -bang -nargs=* Ag
            \ call fzf#vim#ag(
            \ <q-args>, '--color-path "0;37" --color-line-number "0;37" --color-match "" --hidden --smart-case --follow',
            \ <bang>0)

if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

" Grep
command! -nargs=+ -complete=file_in_path -bar Grep     call grep#qf(<q-args>)
command! -nargs=+ -complete=file_in_path -bar Grepadd  call grep#qfadd(<q-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep    call grep#ll(<q-args>)
command! -nargs=+ -complete=file_in_path -bar LGrepadd call grep#lladd(<q-args>)

nnoremap <leader>s :Grep<space>
nnoremap <leader>S :Grepadd<space>

nnoremap <silent> gs :set opfunc=grep#qf_opfunc<CR>g@
xnoremap <silent> gs :<C-u>call grep#qf_opfunc(visualmode(), 1)<CR>

nnoremap <silent> gS :set opfunc=grep#qfadd_opfunc<CR>g@
xnoremap <silent> gS :<C-u>call grep#qfadd_opfunc(visualmode(), 1)<CR>

" Open the location/quickfix window automatically
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
    autocmd QuickFixCmdPost caddexpr cwindow
    autocmd QuickFixCmdPost laddexpr lwindow
augroup END

" GitBlame
command! -range GB echo functions#gitblame('<line1>,<line2>')

" Countrepeat
"nnoremap . :<C-u>exe 'norm! ' . repeat('.', v:count1)<CR>

" Retab
"nnoremap <silent> <leader>i :set opfunc=functions#fix_space_tabstop<CR>g@
"xnoremap <silent> <leader>i :<C-u>call functions#fix_space_tabstop(visualmode(), 1)<CR>


"""""""""""""""""""""
"  PLUGIN SETTINGS  "
"""""""""""""""""""""

" Default key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

" Default fzf layout
let g:fzf_layout = { 'down': '~30%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors = { 
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Special'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'Comment'],
            \ 'border':  ['bg', 'Ignore'],
            \ 'prompt':  ['fg', 'Type'],
            \ 'pointer': ['fg', 'Type'],
            \ 'marker':  ['fg', 'Statement'],
            \ 'spinner': ['fg', 'Comment'],
            \ 'header':  ['fg', 'Type'] }

" Customize the options used by 'git log'
let g:fzf_commits_log_options = '--graph --color=always --pretty=lo'

" Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" FZF
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>w :Windows<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>o :History<CR>
nnoremap <silent> <leader>: :History:<CR>
nnoremap <silent> <leader>/ :History/<CR>

" Mapping selecting mappings
nmap <leader><Tab> <plug>(fzf-maps-n)
xmap <leader><Tab> <plug>(fzf-maps-x)
omap <leader><Tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <C-x><C-k> <plug>(fzf-complete-word)
imap <C-x><C-f> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

" Use custom dictionary
inoremap <expr> <C-x><C-k> fzf#complete('cat /usr/share/dict/words-insane')

" Lightline
let g:lightline = {}
let g:lightline.colorscheme = 'gruvbox'

"" Powerline    
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

"" Straight ▌ │ ▐ │ or ▌ ▏ ▐ ▕
"let g:lightline.separator = { 'left': '▌', 'right': '▐' }
"let g:lightline.subseparator = { 'left': '│', 'right': '│' }

let g:lightline.active = {
            \ 'left': [ [ 'filename', 'paste' ],
            \           [ 'gitbranch' ],
            \           [ 'spell', 'readonly', 'modified' ] ],
            \ 'right': [ [ 'lsp_error', 'lsp_warning', 'lsp_info', 'lsp_hint', 'filetype' ],
            \            [ 'percent', 'lineinfo' ],
            \            [ 'longline', 'mixedindent', 'trailing' ] ]
            \ }

let g:lightline.inactive = {
            \ 'left': [ [ 'filename' ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ] ]
            \ }

let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ] ],
            \ 'right': [ [ 'relativepath' ],
            \            [ 'wordcount', 'fileformat', 'fileencoding' ] ]
            \ }

let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'filename', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'modified' ]
            \ }

let g:lightline.component = {
            \ }

let g:lightline.component_visible_condition = {
            \ }

let g:lightline.component_function = {
            \ 'trailing': 'status#trailing',
            \ 'mixedindent': 'status#mixedindent',
            \ 'longline': 'status#longline',
            \ 'readonly': 'status#readonly',
            \ 'modified': 'status#modified',
            \ 'wordcount': 'status#wordcount',
            \ 'gitbranch': 'status#gitbranch',
            \ }

let g:lightline.component_expand = {
            \ 'lsp_hint': 'languageclient#hints',
            \ 'lsp_info': 'languageclient#infos',
            \ 'lsp_warning': 'languageclient#warnings',
            \ 'lsp_error': 'languageclient#errors'
            \ }

let g:lightline.component_type = {
            \ 'lsp_hint': 'hint',
            \ 'lsp_info': 'info',
            \ 'lsp_warning': 'warning',
            \ 'lsp_error': 'error'
            \ }

let g:languageclient#indicator_error = '✘'
let g:languageclient#indicator_warning = '↯'
let g:languageclient#indicator_info = 'ℹ'
let g:languageclient#indicator_hint = '♥'
let g:languageclient#open_linenr = '['
let g:languageclient#close_linenr = ']'
let g:languageclient#show_linenr = 1

" " Airline
" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
"
" "" Unicode symbols
" let g:airline_left_alt_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_alt_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.crypt = '🔒'
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.maxlinenr = '␤'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.spell = 'Ꞩ'
" let g:airline_symbols.notexists = '∄'
" let g:airline_symbols.whitespace = 'Ξ'
"
" "" Powerline    
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
"
" " "" Straight ▌ │ ▐ │ or ▌ ▏ ▐ ▕
" " let g:airline_left_sep = '▌'
" " let g:airline_left_alt_sep = '│'
" " let g:airline_right_sep = '▐'
" " let g:airline_right_alt_sep = '│'
"
" "" Powerline symbols
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.notexists = ' ∄'
" let g:airline_symbols.dirty = ' ✘'
"
" "" Airline settings
" let g:airline_theme = 'gruvbox'
" let g:airline#extensions#whitespace#mixed_indent_algo = 1
" let g:airline_powerline_fonts = 1
" let g:airline_skip_empty_sections = 0
" let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline#extensions#tabline#tab_nr_type = 1
" let g:airline#extensions#tabline#show_buffers = 1
" let g:airline#extensions#tabline#show_tabs = 1
" let g:airline#extensions#tabline#show_tab_count = 0
" let g:airline#extensions#tabline#show_tab_nr = 0
" let g:airline#extensions#tabline#show_close_button = 0
" let g:airline#extensions#tabline#exclude_preview = 1
" let g:airline#extensions#tabline#fnamecollapse = 1
" let g:airline#extensions#tabline#fnamemod = ':~:.'
" let g:airline#extensions#tabline#buffers_label = 'buffers'
" let g:airline#extensions#tabline#tabs_label = 'tabs'
" let g:airline#extensions#tabline#overflow_marker = '…'
" let g:airline_section_z = '%3p%% %3l:%-2v'
"
" " let g:airline_mode_map = {
" "             \ '__' : ' - ',
" "             \ 'n'  : ' N ',
" "             \ 'i'  : ' I ',
" "             \ 'R'  : ' R ',
" "             \ 'c'  : ' C ',
" "             \ 'v'  : ' V ',
" "             \ 'V'  : 'V-L',
" "             \ '' : 'V-B',
" "             \ 's'  : ' S ',
" "             \ 'S'  : ' S ',
" "             \ '' : ' S ',
" "             \ }
"
" "" Airline extensions
" let g:airline#extensions#ale#error_symbol = ''
" let g:airline#extensions#ale#warning_symbol = ''
" let g:airline#extensions#ale#show_line_numbers = 0
" let g:airline#extensions#whitespace#show_message = 1
" let g:airline#extensions#hunks#enabled = 0

" " Statusline
" set statusline=
"
" " display a warning if fileformat isnt unix
" set statusline+=%#warningmsg#
" set statusline+=%{&ff!='unix'?'['.&ff.']':''}
" set statusline+=%*
"
" " display a warning if file encoding isnt utf-8
" set statusline+=%#warningmsg#
" set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
" set statusline+=%*
"
" set statusline+=%h      "help file flag
" set statusline+=%y      "filetype
" set statusline+=%r      "read only flag
" set statusline+=%m      "modified flag
"
" " display current git branch
" set statusline+=%{fugitive#statusline()}
"
" " display a warning if &et is wrong, or we have mixed-indenting
" set statusline+=%#error#
" set statusline+=%{status#tabWarning()}
" set statusline+=%{status#longLineWarning()}
" set statusline+=%*
"
" set statusline+=%{status#trailingSpaceWarning()}
"
" "set statusline+=%#warningmsg#
" "set statusline+=%{SyntasticStatuslineFlag()}
" "set statusline+=%*
"
" " display a warning if &paste is set
" set statusline+=%#error#
" set statusline+=%{&paste?'[paste]':''}
" set statusline+=%*
"
" set statusline+=%=      "left/right separator
" set statusline+=%-020.{status#currentHighlight()}\ \    "current highlight
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ %P    "percent through file
" set laststatus=2        " Always show status line
"
" " recalculate the trailing whitespace warning when idle, and after saving
" augroup ReloadVars
"     autocmd!
"     autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning
"     autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning
"     autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning
" augroup END

" GitGutter
let g:gitgutter_sign_added = '┃'
let g:gitgutter_sign_modified = '┃'
let g:gitgutter_sign_removed = '◢'
let g:gitgutter_sign_removed_first_line = '◥'
let g:gitgutter_sign_modified_removed = '┻'
let g:gitgutter_map_keys = 0
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>ha <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" Sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" TComment
let g:tcomment_mapleader1 = '<C-,>'
nnoremap <leader>c V:TCommentInline<CR>
xnoremap <leader>c :TCommentInline<CR>

" Netrw
let g:netrw_liststyle = 0
let g:netrw_preview = 1

" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Undotree
nnoremap <silent> <F11> :UndotreeToggle<CR>

" Tagbar
nnoremap <silent> <F12> :TagbarToggle<CR>

" After text object
augroup AfterTextObject
    autocmd!
    autocmd VimEnter * call after_object#enable(['n', 'nn'], '=', ':', '+', '-', '*', '/', '#', ' ')
augroup End

" Vimtex
let g:vimtex_view_method = 'zathura'

" UltiSnips
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-l>'
let g:UltiSnipsJumpBackwardTrigger = '<C-h>'
let g:UltiSnipsEditSplit = "vertical"

let g:snips_author = "Alphonse Mariya"
let g:snips_email = "alphonse.mariya@hotmail.com"
let g:snips_github = "https://github.com/alfunx"

"" Auto
"augroup UltiSnipsExpand
"    autocmd!
"    autocmd CompleteDone * call functions#expand_snippet()
"augroup End

"" Manual
inoremap <silent> <C-k> <C-r>=functions#expand_snippet()<CR>

"" Completion for snippets
inoremap <silent> <C-x><C-z> <C-r>=functions#ulti_complete()<CR>

" Multiple-Cursors
let g:multi_cursor_use_default_mapping = 0
let g:multi_cursor_start_key = '<C-n>'
let g:multi_cursor_select_all_key = '<A-n>'
let g:multi_cursor_start_word_key = 'g<C-n>'
let g:multi_cursor_select_all_word_key = 'g<A-n>'
let g:multi_cursor_next_key = '<C-n>'
let g:multi_cursor_prev_key = '<C-p>'
let g:multi_cursor_skip_key = '<C-x>'
let g:multi_cursor_quit_key = '<Esc>'
let g:multi_cursor_exit_from_visual_mode = 0
let g:multi_cursor_exit_from_insert_mode = 0

" Vimux
let g:VimuxUseNearest = 1

nnoremap <silent> _ mv:set opfunc=functions#send_to_tmux_split<CR>g@
xnoremap <silent> _ mv:<C-u>call functions#send_to_tmux_split(visualmode(), 1)<CR>

" ALE
"" Use special space: ( ) U+2000 (EN QUAD)
let g:ale_set_loclist = 1
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_info = '●'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_completion_enabled = 0

nmap [r <plug>(ale_previous_wrap)
nmap ]r <plug>(ale_next_wrap)
nnoremap <silent> <leader>a :ALEToggle <Bar> echo g:ale_enabled ? 'ALE enabled' : 'ALE disabled' <CR>

augroup ALE
    autocmd!
    autocmd VimEnter * ALEDisable
augroup END

let g:ale_linters = {
            \ 'rust': ['cargo', 'rls', 'rustc'],
            \ }

" AutoPairs
"let g:AutoPairsShortcutBackInsert = '<M-z>'
"let g:AutoPairsMultilineClose = 0
"let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" Pear-Tree
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0
imap <M-z> <Plug>(PearTreeJump)

" RustRacer
let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 0

" LanguageClient
let g:LanguageClient_autoStart = 1
let g:LanguageClient_diagnosticsList = 'Location'
let g:LanguageClient_diagnosticsMaxSeverity = 'Hint'
let g:LanguageClient_hoverPreview = 'Always'
let g:LanguageClient_virtualTextPrefix = '   ← '
let g:LanguageClient_hasSnippetSupport = 1

let g:LanguageClient_serverCommands = {
            \ 'haskell': ['hie-wrapper'],
            \ 'rust':    ['rustup', 'run', 'stable', 'rls'],
            \ 'java':    ['jdtls'],
            \ 'c':       ['ccls'],
            \ 'cpp':     ['ccls'],
            \ 'python':  ['pyls'],
            \ 'lua':     ['lua-lsp'],
            \ 'sh':      ['bash-language-server', 'start'],
            \ }

let g:LanguageClient_diagnosticsDisplay = {
            \     1: {
            \         "name": "Error",
            \         "texthl": "ALEError",
            \         "signText": "●",
            \         "signTexthl": "ALEErrorSign",
            \         "virtualTexthl": "VirtualTextError",
            \     },
            \     2: {
            \         "name": "Warning",
            \         "texthl": "ALEWarning",
            \         "signText": "●",
            \         "signTexthl": "ALEWarningSign",
            \         "virtualTexthl": "VirtualTextWarning",
            \     },
            \     3: {
            \         "name": "Information",
            \         "texthl": "ALEInfo",
            \         "signText": "●",
            \         "signTexthl": "ALEInfoSign",
            \         "virtualTexthl": "VirtualTextInfo",
            \     },
            \     4: {
            \         "name": "Hint",
            \         "texthl": "ALEHint",
            \         "signText": "●",
            \         "signTexthl": "ALEHintSign",
            \         "virtualTexthl": "VirtualTextHint",
            \     },
            \ }

function! LanguageClient_settings()
    if !has_key(g:LanguageClient_serverCommands, &filetype)
        return
    endif
    nnoremap <buffer><silent> K :call LanguageClient_contextMenu()<CR>
    nnoremap <buffer><silent> <F1> :call LanguageClient_textDocument_hover()<CR>
    nnoremap <buffer><silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
    nnoremap <buffer><silent> <leader>i :call LanguageClient#textDocument_implementation()<CR>
    nnoremap <buffer><silent> <leader>x :call LanguageClient_textDocument_typeDefinition()<CR>
    nnoremap <buffer><silent> <leader>y :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <buffer><silent> <leader>u :call LanguageClient_textDocument_references()<CR>
    nnoremap <buffer><silent> <leader>rn :call LanguageClient_textDocument_rename()<CR>
    nnoremap <buffer><silent> <leader>rc :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>rs :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>ru :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>
endfunction

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted set signcolumn=yes
    autocmd User LanguageClientStopped set signcolumn=auto
    autocmd FileType * call LanguageClient_settings()
    autocmd BufEnter __LanguageClient__ nnoremap <silent> <F1> :q<CR>
augroup END

" " vim-lsp
" let g:lsp_signs_error = {'text': '●'}
" let g:lsp_signs_warning = {'text': '●'}
" let g:lsp_signs_information = {'text': '●'}
" let g:lsp_signs_hint = {'text': '●'}
" let g:lsp_highlight_references_enabled = 1
"
" hi! link LspErrorHighlight ALEError
" hi! link LspWarningHighlight ALEWarning
" hi! link LspInformationHighlight ALEInfo
" hi! link LspHintHighlight ALEHint
"
" hi! link LspErrorText VirtualTextError
" hi! link LspWarningText VirtualTextWarning
" hi! link LspInformationText VirtualTextInfo
" hi! link LspHintText VirtualTextHint
"
" hi! link LspError ALEErrorSign
" hi! link LspWarning ALEWarningSign
" hi! link LspInformation ALEInfoSign
" hi! link LspHint ALEHintSign
"
" if executable('ccls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'ccls',
"         \ 'cmd': ['ccls'],
"         \ 'whitelist': ['c', 'cpp'],
"         \ })
" endif
"
" if executable('ccls')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'rls',
"         \ 'cmd': ['rustup', 'run', 'stable', 'rls'],
"         \ 'whitelist': ['rust'],
"         \ })
" endif

" vim-speeddating
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)

" vim-rsi
let g:rsi_no_meta = 1

" vim-dispatch
nnoremap <F5> :Make<CR>

" vim-qf
let g:qf_mapping_ack_style = 1
nmap <silent> [q <Plug>(qf_qf_previous)
nmap <silent> ]q <Plug>(qf_qf_next)
nmap <silent> [w <Plug>(qf_loc_previous)
nmap <silent> ]w <Plug>(qf_loc_next)
nmap <silent> <leader>q <Plug>(qf_qf_toggle_stay)
nmap <silent> <leader>l <Plug>(qf_loc_toggle_stay)
nmap <silent> <leader><leader> <Plug>(qf_qf_switch)


""""""""""""""
"  SETTINGS  "
""""""""""""""

set number
set hidden
set cursorline
set list
set nowrap
set mouse=ar
set laststatus=2
set showtabline=2
set tabpagemax=50
set previewheight=5
set noshowmode
set hlsearch
set incsearch
set ignorecase
set smartcase
set autoread
set noruler
set nostartofline

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
set textwidth=80
set scrolloff=3
set sidescroll=1
set sidescrolloff=5

set wildmode=longest:full,full
set complete-=i
set completeopt=menuone,noinsert,noselect
set shortmess+=aIc shortmess-=S
set diffopt+=hiddenoff,algorithm:histogram
set clipboard+=unnamed,unnamedplus
set formatoptions+=rj formatoptions-=o
set nrformats-=octal
set pastetoggle=<F2>
set history=10000
set sessionoptions-=options
set nojoinspaces
set belloff=all
set lazyredraw
set synmaxcol=800
set dictionary+=/usr/share/dict/words-insane
set tags^=./.git/tags

set guifont=monospace
set guioptions-=mTrl

if &term !=? 'linux' || has('gui_running')
    set listchars=tab:›\ ,extends:❯,precedes:❮,nbsp:˷,trail:~
    "set listchars=tab:›\ ,extends:❯,precedes:❮,nbsp:˷,eol:⤶,trail:~
    set fillchars=vert:│,fold:─,diff:\ 
    "augroup InsertModeHideTrailingSpaces
    "    autocmd!
    "    autocmd InsertEnter * set listchars-=eol:⤶ listchars-=trail:~
    "    autocmd InsertLeave * set listchars+=eol:⤶,trail:~
    "augroup END
else
    set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,trail:~
    "set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,eol:$,trail:~
    set fillchars=vert:\|,fold:-,diff:\ 
    "augroup InsertModeHideTrailingSpaces
    "    autocmd!
    "    autocmd InsertEnter * set listchars-=eol:$ listchars-=trail:~
    "    autocmd InsertLeave * set listchars+=eol:$,trail:~
    "augroup END
endif


"""""""""""""
"  AUTOCMD  "
"""""""""""""

augroup SourceVimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup UnfoldInitially
    autocmd!
    autocmd BufWinEnter * let &foldlevel=max(add(map(range(1, line('$')), 'foldlevel(v:val)'), 10))
augroup End

function! CustomFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '┤ ' . printf("%10s", lines_count . ' lines') . ' ├'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart(' + ' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=CustomFoldText()


""""""""""""
"  NEOVIM  "
""""""""""""

if has('nvim')
    set inccommand=nosplit
    set pumblend=0
    set fillchars+=eob:\ 
endif

if !has('nvim')
    set display=lastline
    set viminfo=%,\"800,'10,/50,:100,h,f0,n~/.vim/.viminfo
    augroup SavePosition
        autocmd!
        autocmd BufReadPost *
                    \ if index(['gitcommit', 'gitrebase'], &ft) < 0 &&
                    \ line("'\"") > 0 && line("'\"") <= line("$") |
                    \ exec 'normal! g`"zvzz' |
                    \ endif
    augroup END
endif

if has('nvim') || has('gui_running')
    augroup FZFHideStatus
        autocmd! FileType fzf
        autocmd FileType fzf set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
    augroup END
endif


""""""""""""""""""""""""""
"  BACKUP / SWAP / UNDO  "
""""""""""""""""""""""""""

if !isdirectory($HOME . '/.vim/.backup')
    silent !mkdir -p ~/.vim/.backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/.backup/
set backupdir^=./.vim-backup/
set backup

if !isdirectory($HOME . '/.vim/.swap')
    silent !mkdir -p ~/.vim/.swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/.swap//
set directory+=~/.tmp//
set directory+=.

if exists('+undofile')
    if !isdirectory($HOME . '/.vim/.undo')
        silent !mkdir -p ~/.vim/.undo >/dev/null 2>&1
    endif
    set undodir=./.vim-undo//
    set undodir+=~/.vim/.undo//
    set undofile
endif


"""""""""""""""""
"  LOCAL VIMRC  "
"""""""""""""""""

" function! SourceLocalVimrc()
"     if filereadable(".local.vimrc") && confirm("Source '.local.vimrc?'", "&Yes\nNo", 1)
"         silent! source .local.vimrc
"     endif
" endfunction
" autocmd VimEnter * call SourceLocalVimrc()

silent! source .local.vimrc


"""""""""""
"  LINKS  "
"""""""""""

"" Links to check out

" checkout: https://github.com/romainl/idiomatic-vimrc
"           https://gist.github.com/romainl/4b9f139d2a8694612b924322de1025ce
"           https://github.com/zenbro/dotfiles/blob/master/.nvimrc
"           https://github.com/spf13/spf13-vim/blob/3.0/.vimrc
"           https://github.com/euclio/vimrc/blob/master/vimrc
"           https://github.com/KevOBrien/dotfiles
"           https://bitbucket.org/sjl/dotfiles/src/28205343c464b44fd36970d2588a74183ff73299/vim/vimrc
