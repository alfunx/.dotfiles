"""""""""""
"  VIMRC  "
"""""""""""

" Setup directories and vim-plug {{{

if !filereadable($HOME . '/.vim/autoload/plug.vim')
    silent !mkdir -p ~/.vim/autoload >/dev/null 2>&1
    silent !mkdir -p ~/.vim/plugged >/dev/null 2>&1
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                \ >/dev/null 2>&1
    autocmd VimEnter * PlugInstall
endif

" }}}

" Plugins {{{

call plug#begin('~/.vim/plugged')

let g:plug_url_format = 'https://github.com/%s.git'

" FZF
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug '/usr/bin/fzf'

" General
"Plug 'junegunn/fzf.vim'  " forked
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'Konfekt/vim-CtrlXA'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-scriptease'
"Plug 'tpope/vim-commentary'
"Plug 'tomtom/tcomment_vim'  " forked
"Plug 'whiteinge/diffconflicts'  " forked
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'airblade/vim-gitgutter'
"Plug 'godlygeek/tabular'
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
"Plug 'romainl/vim-qf'  " forked
"Plug 'rhysd/git-messenger.vim'  " forked
Plug 'sheerun/vim-polyglot'
"Plug 'wellle/context.vim'
"Plug 'liuchengxu/vista.vim'
"Plug 'fszymanski/fzf-quickfix'

" Text objects
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-after-object'
"Plug 'michaeljsmith/vim-indent-object'  " forked
Plug 'kana/vim-textobj-user'
Plug 'Julian/vim-textobj-variable-segment'

" Tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/tmux-complete.vim'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Snippets
Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'  " forked

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
Plug 'tweekmonster/helpful.vim', { 'for': ['vim', 'help'] }

" Syntax
Plug 'cespare/vim-toml'
Plug 'tomlion/vim-solidity'

" Themes
"Plug 'morhetz/gruvbox'  "forked
Plug 'lifepillar/vim-gruvbox8'

" Don't load in console
if &term !=? 'linux' || has('gui_running')
    "Plug 'vim-airline/vim-airline'
    Plug 'itchyny/lightline.vim'
endif

Plug 'vim/killersheep'

let g:plug_url_format = 'git@github.com:%s.git'

Plug 'alfunx/fzf.vim'  " fork of 'junegunn/fzf.vim'
Plug 'alfunx/tcomment_vim'  " fork of 'tomtom/tcomment_vim'
Plug 'alfunx/diffconflicts'  " fork of 'whiteinge/diffconflicts'
Plug 'alfunx/vim-qf'  " fork of 'romainl/vim-qf'
Plug 'alfunx/git-messenger.vim'  " fork of 'rhysd/git-messenger.vim'
Plug 'alfunx/vim-indent-object'  " fork of 'michaeljsmith/vim-indent-object'
Plug 'alfunx/vim-snippets'  " fork of 'honza/vim-snippets'
Plug 'alfunx/gruvbox'  " fork of 'morhetz/gruvbox'

call plug#end()

if !has('nvim') && has('patch-7.4.2111')
    unlet! skip_defaults_vim
    source $VIMRUNTIME/defaults.vim
endif

if !has('nvim')
    runtime ftplugin/man.vim
    runtime macros/matchit.vim
endif

" }}}

" Theme {{{

augroup QuickFixHighlighting
    autocmd!
    autocmd ColorScheme * hi! QuickFixLine term=bold cterm=bold gui=bold
    autocmd ColorScheme * hi! link qfFileName Special
augroup END

augroup MarkdownFenceHighlighting
    autocmd!
    autocmd ColorScheme * hi! link mkdCodeStart Comment
    autocmd ColorScheme * hi! link mkdCodeEnd Comment
    autocmd ColorScheme * hi! link mkdCodeDelimiter Comment
augroup END

augroup ConflictMarkerHighlighting
    autocmd!
    autocmd ColorScheme * hi! link VcsConflict Error
    autocmd BufEnter,WinEnter * match VcsConflict '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$'
augroup END

augroup StatusLineUpdate
    autocmd!
    if exists(':AirlineRefresh')
        autocmd ColorScheme * AirlineRefresh
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
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1
colorscheme gruvbox

" }}}

" Compatibility {{{

" Switch cursor according to mode
if !has('nvim') || &term !=? 'linux' || has('gui_running')
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    "set t_Co=256

    let &t_SI="\<Esc>[6 q"
    let &t_SR="\<Esc>[4 q"
    let &t_EI="\<Esc>[2 q"
    let &t_ue="\<Esc>[4:0m"
    let &t_us="\<Esc>[4:2m"
    "let &t_Ce="\<Esc>[4:0m"
    "let &t_Cs="\<Esc>[4:3m"
    let &t_Ce="\<Esc>[4:0;59m"
    let &t_Cs="\<Esc>[4:3;58;5;167m"
endif

" Alt key mappings
if !has('nvim')
    for c in split('0123456789', '\zs')
        silent execute "set <M-" . c . ">=\<Esc>" . c
    endfor
    for c in split('abcdefghijklmnopqrstuvwxyz', '\zs')
        silent execute "set <M-" . c . ">=\<Esc>" . c
        silent execute "set <M-S-" . c . ">=\<Esc>" . toupper(c)
    endfor
    silent execute "set <M-S-p>="
endif

" }}}

" Mapping {{{

" Leader key
nnoremap <Space> <Nop>
nnoremap <CR> <Nop>
let mapleader = ' '
let maplocalleader = ''

" Split navigation
if exists(':TmuxNavigate')
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <C-h>  :TmuxNavigateLeft<CR>
    nnoremap <silent> <C-j>  :TmuxNavigateDown<CR>
    nnoremap <silent> <C-k>  :TmuxNavigateUp<CR>
    nnoremap <silent> <C-l>  :TmuxNavigateRight<CR>
    nnoremap <silent> <C-BS> :TmuxNavigatePrevious<CR>
else
    nnoremap <silent> <C-h> <C-w><C-h>
    nnoremap <silent> <C-j> <C-w><C-j>
    nnoremap <silent> <C-k> <C-w><C-k>
    nnoremap <silent> <C-l> <C-w><C-l>
endif

" Split resize
nnoremap <silent> <C-w>h 5<C-w><
nnoremap <silent> <C-w>j 5<C-w>-
nnoremap <silent> <C-w>k 5<C-w>+
nnoremap <silent> <C-w>l 5<C-w>>

" New tab
nnoremap <silent> <C-w>t     :tabnew<CR>
nnoremap <silent> <C-w><C-t> :tabnew<CR>

" Close tab
nnoremap <silent> <C-w>b     :tabclose<CR>
nnoremap <silent> <C-w><C-b> :tabclose<CR>

" Tab navigation
nnoremap <silent> <M-S-h> gT
nnoremap <silent> <M-S-l> gt

" Move tab
nnoremap <silent> <M-S-j> :tabmove -1<CR>
nnoremap <silent> <M-S-k> :tabmove +1<CR>

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
xnoremap <silent> ie GoggV
onoremap <silent> ie :<C-u>normal vie<CR>
xnoremap <silent> ae GoggV
onoremap <silent> ae :<C-u>normal vie<CR>

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

" Jump paragraphs
nmap <silent> <M-j> }
xmap <silent> <M-j> }
omap <silent> <M-j> }
nmap <silent> <M-k> {
xmap <silent> <M-k> {
omap <silent> <M-k> {

" Jump to definition
nmap <silent> è <C-]>
xmap <silent> è <C-]>

" Wildmenu
set wildchar=<Tab>
set wildcharm=<Tab>
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? '<C-g>' : '<Tab>'
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? '<C-t>' : '<S-Tab>'

" Remove trailing whitespaces
nnoremap <silent> <F3> m`:keeppatterns %s/\\\@1<!\s\+$//e<CR>``

" Allow saving of files as sudo
command! W exe 'silent! w !sudo /usr/bin/tee % >/dev/null' <Bar> edit!

" Set path to current file
command! -bang -nargs=* Cd cd<bang> %:p:h

" Compare buffer to file on disk
command! DiffOrig vnew | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" No highlight
nnoremap <silent> <M-b> :<C-u>nohlsearch<CR>

" Run last macro
nnoremap Q @@

" Run macro on visual selection
nnoremap <silent> <leader>@ :set opfunc=opfunc#visual_macro<CR>g@
xnoremap <silent>         @ :<C-u>call opfunc#visual_macro(visualmode(), 1)<CR>

" Change register
nnoremap <silent> cx :<C-u>call functions#change_register()<CR>

" Google
nnoremap <silent> <leader>? :set opfunc=opfunc#google<CR>g@
xnoremap <silent>         ? :<C-u>call opfunc#google(visualmode(), 1)<CR>

" Copy path:line
"nnoremap <silent> <F4> :<C-u>exe "!tmux send -t " . v:count . " 'b " . expand("%:p") . ":" . line(".") . "' C-m"<CR>
"nnoremap <silent> <F4> :call system("tmux send -t monetDB:server 'b " . expand("%:p") . ":" . line(".") . "' C-m")<CR>
nnoremap <silent> <F4> :<C-u>let @+ = expand('%:p') . ':' . line('.')<CR>

" Display highlighting info
nnoremap <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
            \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
            \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" RG
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ 'rg --hidden --line-number --column --smart-case --follow --no-heading --color=always ' .
            \ '--colors="match:none" --colors="path:fg:white" --colors="line:fg:white" 2>/dev/null ' .
            \ shellescape(<q-args>), 1,
            \ <bang>0)

" AG
command! -bang -nargs=* Ag
            \ call fzf#vim#ag(
            \ <q-args>, '--hidden --number --column --smart-case --follow --nogroup --color ' .
            \ '--color-path "0;37" --color-line-number "0;37" --color-match "" ',
            \ <bang>0)

" Grep
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

" Grep
command! -bang -nargs=+ -complete=file_in_path -bar Grep
            \ call grep#qf(<bang>0?'--pcre2':'', <q-args>)
command! -bang -nargs=+ -complete=file_in_path -bar Grepadd
            \ call grep#qfadd(<bang>0?'--pcre2':'', <q-args>)
command! -bang -nargs=+ -complete=file_in_path -bar LGrep
            \ call grep#ll(<bang>0?'--pcre2':'', <q-args>)
command! -bang -nargs=+ -complete=file_in_path -bar LGrepadd
            \ call grep#lladd(<bang>0?'--pcre2':'', <q-args>)

nnoremap <leader>s :Grep<space>
nnoremap <leader>S :Grepadd<space>

nnoremap <silent> gs :set opfunc=grep#qf_opfunc<CR>g@
xnoremap <silent> gs :<C-u>call grep#qf_opfunc(visualmode(), 1)<CR>

nnoremap <silent> gS :set opfunc=grep#qfadd_opfunc<CR>g@
xnoremap <silent> gS :<C-u>call grep#qfadd_opfunc(visualmode(), 1)<CR>

" Open the quickfix/location window automatically
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr,caddexpr cwindow
    autocmd QuickFixCmdPost lgetexpr,laddexpr lwindow
augroup END

" GitBlame
command! -range GBlame echo functions#gitblame('<line1>,<line2>')

" Countrepeat
"nnoremap . :<C-u>exe 'norm! ' . repeat('.', v:count1)<CR>

" Retab
"nnoremap <silent> <leader>i :set opfunc=opfunc#fix_space_tabstop<CR>g@
"xnoremap <silent> <leader>i :<C-u>call opfunc#fix_space_tabstop(visualmode(), 1)<CR>

" Incremental dot
nnoremap c* *``cgn
nnoremap c# #``cgN

" Differential dot
nnoremap        § *``gn<C-g>
inoremap        § <C-o>gn<C-g>
xnoremap        § "vy:let @/ = @v<CR>gn<C-g>
snoremap <expr> . @.

" Custom operators
call map#action('functions#trim', '<leader>zz')
call map#action('functions#bin', '<leader>zb')
call map#action('functions#hex', '<leader>zx')
call map#action('functions#dec', '<leader>zd')

" Completion for snippets
inoremap <silent> <C-x><C-z> <C-r>=completion#ultisnips()<CR>

" Completion for tmux
inoremap <silent> <C-x><C-i> <C-r>=completion#tmux()<CR>

" }}}

" Plugin settings {{{

" fzf.vim
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>w :Windows<CR>
nnoremap <silent> <leader>t :Tags<CR>
nnoremap <silent> <leader>o :History<CR>
nnoremap <silent> <leader>: :History:<CR>
nnoremap <silent> <leader>/ :History/<CR>

"" Mapping selecting mappings
nmap <leader><Tab> <plug>(fzf-maps-n)
xmap <leader><Tab> <plug>(fzf-maps-x)
omap <leader><Tab> <plug>(fzf-maps-o)

"" Insert mode completion
imap <C-x><C-k> <plug>(fzf-complete-word)
imap <C-x><C-f> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

"" Use custom dictionary
inoremap <expr> <C-x><C-k> fzf#complete('cat /usr/share/dict/words-insane')

"" Default key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

"" Default fzf layout
let g:fzf_layout = { 'down': '~30%' }

"" Customize fzf colors to match your color scheme
let g:fzf_colors = {
            \ 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Special'],
            \ 'fg+':     ['fg', 'Normal'],
            \ 'bg+':     ['bg', 'Normal'],
            \ 'gutter':  ['bg', 'Normal'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'LineNr'],
            \ 'border':  ['bg', 'Ignore'],
            \ 'prompt':  ['fg', 'Type'],
            \ 'pointer': ['fg', 'Type'],
            \ 'marker':  ['fg', 'Statement'],
            \ 'spinner': ['fg', 'LineNr'],
            \ 'header':  ['fg', 'Type'] }

"" Customize the options used by 'git log'
let g:fzf_commits_log_options = '--graph --color=always --pretty=lo'

"" Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" vim-gitgutter
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

" vim-sneak
let g:sneak#label = 1
let g:sneak#use_ic_scs = 1
nmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
xmap f <Plug>Sneak_f
xmap F <Plug>Sneak_F
xmap t <Plug>Sneak_t
xmap T <Plug>Sneak_T

" tcomment_vim
let g:tcomment_mapleader1 = '<C-,>'
nnoremap <leader>gc V:TCommentInline<CR>
xnoremap <leader>gc :TCommentInline<CR>

" netrw
let g:netrw_liststyle = 0
let g:netrw_preview = 1

" vim-dirvish
let g:loaded_netrwPlugin = 1
command! -nargs=? -complete=dir Explore Dirvish <args>
command! -nargs=? -complete=dir Sexplore belowright split | silent Dirvish <args>
command! -nargs=? -complete=dir Vexplore leftabove vsplit | silent Dirvish <args>
nmap - <Plug>(dirvish_up)

" vim-easy-align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" undotree
nnoremap <silent> <F11> :UndotreeToggle<CR>

" tagbar
nnoremap <silent> <F12> :TagbarToggle<CR>

" vim-after-object
augroup AfterTextObject
    autocmd!
    autocmd VimEnter * call after_object#enable(['n', 'nn'], '=', ':', '+', '-', '*', '/', '#', ' ')
augroup End

" vimtex
let g:vimtex_view_method = 'zathura'

" ultisnips
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

" vim-multiple-cursors
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

" vimux
let g:VimuxUseNearest = 1
let g:tmuxcomplete#trigger = ''
nnoremap <silent> _ mv:set opfunc=opfunc#send_to_tmux_split<CR>g@
xnoremap <silent> _ mv:<C-u>call opfunc#send_to_tmux_split(visualmode(), 1)<CR>

" auto-pairs
"let g:AutoPairsShortcutBackInsert = '<M-z>'
"let g:AutoPairsMultilineClose = 0
"let g:AutoPairs = {'(':')', '[':']', '{':'}', "'":"'", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

" pear-tree
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0
imap <M-z> <Plug>(PearTreeJump)

" git-messenger
let g:git_messenger_no_default_mappings = 1
nmap gb <Plug>(git-messenger)

" vim-racer
let g:racer_cmd = "/usr/bin/racer"
let g:racer_experimental_completer = 0

" vim-speeddating
nmap <Plug>SpeedDatingFallbackUp   <Plug>(CtrlXA-CtrlA)
nmap <Plug>SpeedDatingFallbackDown <Plug>(CtrlXA-CtrlX)

" vim-rsi
let g:rsi_no_meta = 1

" vim-abolish
"" Coercion on command-line (e.g. for renaming variables with LSP)
cnoremap <expr> <C-x>c       "\<C-u>" . g:Abolish.camelcase(getcmdline())
cnoremap <expr> <C-x>m       "\<C-u>" . g:Abolish.mixedcase(getcmdline())
cnoremap <expr> <C-x>_       "\<C-u>" . g:Abolish.snakecase(getcmdline())
cnoremap <expr> <C-x>s       "\<C-u>" . g:Abolish.snakecase(getcmdline())
cnoremap <expr> <C-x>u       "\<C-u>" . g:Abolish.uppercase(getcmdline())
cnoremap <expr> <C-x>U       "\<C-u>" . g:Abolish.uppercase(getcmdline())
cnoremap <expr> <C-x>-       "\<C-u>" . g:Abolish.dashcase(getcmdline())
cnoremap <expr> <C-x>k       "\<C-u>" . g:Abolish.dashcase(getcmdline())
cnoremap <expr> <C-x>.       "\<C-u>" . g:Abolish.dotcase(getcmdline())
cnoremap <expr> <C-x>t       "\<C-u>" . g:Abolish.titlecase(getcmdline())
cnoremap <expr> <C-x><space> "\<C-u>" . g:Abolish.spacecase(getcmdline())

" vim-dispatch
nnoremap <F5> :Make<CR>

" vim-qf
let g:qf_mapping_ack_style = 1
let g:qf_bufname_or_text = 2
nmap <silent> [q <Plug>(qf_qf_previous)
nmap <silent> ]q <Plug>(qf_qf_next)
nmap <silent> [w <Plug>(qf_loc_previous)
nmap <silent> ]w <Plug>(qf_loc_next)
nmap <silent> <Left>  <Plug>(qf_qf_previous)
nmap <silent> <Right> <Plug>(qf_qf_next)
nmap <silent> <Up>    <Plug>(qf_loc_previous)
nmap <silent> <Down>  <Plug>(qf_loc_next)
nmap <silent> <leader>q        <Plug>(qf_qf_toggle_stay)
nmap <silent> <leader>l        <Plug>(qf_loc_toggle_stay)
nmap <silent> <leader><leader> <Plug>(qf_qf_switch)

" }}}

" Statusline {{{

" Lightline
let g:lightline = {}
let g:lightline.colorscheme = g:colors_name

"" Powerline    
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

"" Straight ▌ │ ▐ │ or ▌ ▏ ▐ ▕
"let g:lightline.separator = { 'left': '▌', 'right': '▐' }
"let g:lightline.subseparator = { 'left': '│', 'right': '│' }

let g:lightline.active = {
            \ 'left': [ [ 'fileinfo', 'paste' ],
            \           [ 'gitbranch', 'qfname' ],
            \           [ 'spell' ] ],
            \ 'right': [ [ 'lsp_error', 'lsp_warning', 'lsp_info', 'lsp_hint', 'filetype' ],
            \            [ 'percent', 'lineinfo' ],
            \            [ 'longline', 'mixedindent', 'trailing' ] ],
            \ }

let g:lightline.inactive = {
            \ 'left': [ [ 'fileinfo' ],
            \           [ 'qfname' ],
            \           [  ] ],
            \ 'right': [ [ 'lineinfo' ],
            \            [ 'percent' ],
            \            [  ] ],
            \ }

let g:lightline.tabline = {
            \ 'left': [ [ 'tabs' ],
            \           [  ] ],
            \ 'right': [ [ 'relativepath' ],
            \            [ 'wordcount', 'fileformat', 'fileencoding' ] ],
            \ }

let g:lightline.tab = {
            \ 'active': [ 'tabnum', 'filename', 'readonly', 'modified' ],
            \ 'inactive': [ 'tabnum', 'filename', 'readonly', 'modified' ],
            \ }

let g:lightline.component = {
            \ 'path': '%{expand("%:p:~:.:s?^$?./?:s?^term://.*#FZF$?[FZF]?")}',
            \ 'fileinfo': '%t%{status#fileinfo()}',
            \ }

let g:lightline.component_visible_condition = {
            \ }

let g:lightline.component_function = {
            \ 'relativepath': 'status#relativepath',
            \ 'trailing': 'status#trailing',
            \ 'mixedindent': 'status#mixedindent',
            \ 'longline': 'status#longline',
            \ 'readonly': 'status#readonly',
            \ 'modified': 'status#modified',
            \ 'wordcount': 'status#wordcount',
            \ 'gitbranch': 'status#gitbranch',
            \ 'qfname': 'status#qfname',
            \ }

let g:lightline.component_expand = {
            \ 'lsp_hint': 'languageclient#hints',
            \ 'lsp_info': 'languageclient#infos',
            \ 'lsp_warning': 'languageclient#warnings',
            \ 'lsp_error': 'languageclient#errors',
            \ }

let g:lightline.component_type = {
            \ 'lsp_hint': 'hint',
            \ 'lsp_info': 'info',
            \ 'lsp_warning': 'warning',
            \ 'lsp_error': 'error',
            \ }

let g:lightline.tab_component = {
            \ }

let g:lightline.tab_component_function = {
            \ 'readonly': 'status#tab_readonly',
            \ 'modified': 'status#tab_modified',
            \ 'tabnum': 'status#tab_tabnum',
            \ }

let g:languageclient#indicator_error = '✘'
let g:languageclient#indicator_warning = '↯'
let g:languageclient#indicator_info = 'ℹ'
let g:languageclient#indicator_hint = '♥'
let g:languageclient#open_linenr = '['
let g:languageclient#close_linenr = ']'
let g:languageclient#show_linenr = 0

" }}}

" LSP / Linting {{{

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
            \ 'objc':    ['ccls'],
            \ 'python':  ['pyls'],
            \ 'lua':     ['lua-lsp'],
            \ 'sh':      ['bash-language-server', 'start'],
            \ 'tex':     ['texlab'],
            \ 'bib':     ['texlab'],
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
    nnoremap <buffer><silent> K          :call LanguageClient#contextMenu()<CR>
    nnoremap <buffer><silent> <F1>       :call LanguageClient#textDocument_hover()<CR>
    nnoremap <buffer><silent> <leader>d  :call LanguageClient#textDocument_definition()<CR>
    nnoremap <buffer><silent> <leader>i  :call LanguageClient#textDocument_implementation()<CR>
    nnoremap <buffer><silent> <leader>x  :call LanguageClient#textDocument_typeDefinition()<CR>
    nnoremap <buffer><silent> <leader>y  :call LanguageClient#textDocument_documentSymbol()<CR>
    nnoremap <buffer><silent> <leader>u  :call LanguageClient#textDocument_references()<CR>
    nnoremap <buffer><silent> <leader>r  :call LanguageClient#textDocument_rename()<CR>
    nnoremap <buffer><silent> <leader>cc :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>cm :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.mixedcase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>c_ :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>cs :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>cu :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>cU :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>c- :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.dashcase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>ck :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.dashcase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>c. :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.dotcase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>ct :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.titlecase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>c<space> :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.spacecase(expand('<cword>'))})<CR>
endfunction

augroup LanguageClient_config
    autocmd!
    autocmd FileType * call LanguageClient_settings()
    autocmd BufEnter __LanguageClient__ nnoremap <buffer><silent> <F1> :q<CR>
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
" if executable('rustup')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'rls',
"         \ 'cmd': ['rustup', 'run', 'stable', 'rls'],
"         \ 'whitelist': ['rust'],
"         \ })
" endif

" ALE
let g:ale_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_set_quickfix = 0
let g:ale_set_loclist = 0
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_filetype_changed = 1
let g:ale_set_highlights = 1
let g:ale_set_signs = 1
let g:ale_completion_enabled = 0

"" Use special space: ( ) U+2000 (EN QUAD)
let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_info = '●'
let g:ale_sign_hint = '●'

nmap [r <plug>(ale_previous_wrap)
nmap ]r <plug>(ale_next_wrap)
nnoremap <silent> <leader>a :ALEToggle <Bar> echo g:ale_enabled ? 'ALE enabled' : 'ALE disabled' <CR>

" }}}

" Settings {{{

set nonumber
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
set wildignorecase
set wildignore+=.ignore,.gitignore
set wildignore+=*/.git/,*/.hg/,*/.svn/
set wildignore+=*/.ccls-cache/,*/.clangd/
set wildignore+=*.o,*.so,*.class,*.exe,*.dll,*.com
set wildignore+=.tmux,.nvimrc,.vimrc,.exrc
set wildignore+=tags,.tags,*/.backup/,*/.vim-backup/,*/.swap/,*/.vim-swap/,*/.undo/,*/.vim-undo/,*/._pkg/
set wildignore+=*.cache,*.log,*~,*#,*.bak,*.BAK,*.old,*.OLD,*.off,*.OFF,*.dist,*.DIST,*.orig,*.ORIG,*.rej,*.REJ,.DS_Store*
set wildignore+=*.swp,*.swo,*.swn,*.swm,*.tmp
set wildignore+=*.pid,*.state
set wildignore+=*.dump,*.stackdump,*.zcompdump,*.zwc,*.pcap,*.cap,*.dmp
set wildignore+=*.err,*.error,*.stderr
set wildignore+=*history,*_history,*_hist
set wildignore+=*_rsa,*_rsa.*,*_dsa,*_dsa.*,*_keys,*.pem,*.key,*.gpg

set complete-=i
set completeopt=menuone,noinsert,noselect
set shortmess+=aIc shortmess-=S
set diffopt+=hiddenoff,algorithm:histogram
set formatoptions+=rj formatoptions-=o
set nrformats-=octal
set pastetoggle=<F2>
set signcolumn=yes
set history=10000
set sessionoptions-=options
set nojoinspaces
set belloff=all
set lazyredraw
set synmaxcol=800
set dictionary+=/usr/share/dict/words-insane
set tags^=./.git/tags
set foldtext=functions#foldtext()

set guifont=monospace
set guioptions-=mTrl

if &term !=? 'linux' || has('gui_running')
    "set listchars=tab:›\ ,extends:❯,precedes:❮,nbsp:˷,eol:⤶,trail:~
    set listchars=tab:›\ ,extends:❯,precedes:❮,nbsp:˷,trail:~
    set fillchars=vert:│,fold:─,diff:\ 
    "augroup InsertModeHideTrailingSpaces
    "    autocmd!
    "    autocmd InsertEnter * set listchars-=eol:⤶ listchars-=trail:~
    "    autocmd InsertLeave * set listchars+=eol:⤶,trail:~
    "augroup END
else
    "set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,eol:$,trail:~
    set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,trail:~
    set fillchars=vert:\|,fold:-,diff:\ 
    "augroup InsertModeHideTrailingSpaces
    "    autocmd!
    "    autocmd InsertEnter * set listchars-=eol:$ listchars-=trail:~
    "    autocmd InsertLeave * set listchars+=eol:$,trail:~
    "augroup END
endif

" }}}

" Autocmd {{{

augroup SourceVimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup GitGutterUpdate
    autocmd!
    autocmd BufWritePost * GitGutter
augroup END

augroup UnfoldInitially
    autocmd!
    autocmd BufWinEnter * let &foldlevel=max(add(map(range(1, line('$')), 'foldlevel(v:val)'), 10))
augroup End

augroup DirvishConceal
    autocmd!
    autocmd BufWritePre dirvish set conceallevel=2
augroup End

" }}}

" NeoVim {{{

if has('nvim')
    set inccommand=nosplit
    set pumblend=0
    set winblend=0
    set fillchars+=eob:·

    augroup RestorePosition
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") &&
                    \ index(['gitcommit', 'gitrebase'], &ft) < 0 |
                    \ exe 'normal! g`"zvzz' |
                    \ endif
    augroup End
endif

if !has('nvim')
    set display=lastline
    set viminfo=%,\"800,'10,/50,:100,h,f0,n~/.vim/.viminfo
endif

if has('nvim') && has('termguicolors') && &termguicolors
    let $FZF_DEFAULT_OPTS .= ' --reverse'
    function! FloatingFZF()
        let width = min([&columns - 2, float2nr(&columns * 0.5)])
        let height = min([&lines - 8, float2nr(&lines * 0.6)])
        let opts = { 'relative': 'editor',
                    \ 'width': width,
                    \ 'height': height,
                    \ 'row': (&lines - height) / 2,
                    \ 'col': (&columns - width) / 2,
                    \ 'style': 'minimal',
                    \ 'border': v:true }
        call functions#nvim_open_window(nvim_create_buf(v:false, v:true), v:true, opts)
    endfunction
    let g:fzf_layout = { 'window': 'call FloatingFZF()' }
elseif has('nvim') || has('gui_running')
    augroup FZFHideStatus
        autocmd! FileType fzf
        autocmd FileType fzf set laststatus=0 | autocmd BufLeave <buffer> set laststatus=2
    augroup END
endif

" }}}

" Backup / Swap / Undo {{{

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

" }}}

" Local vimrc {{{

set exrc
set secure

" }}}

" Links {{{

" https://github.com/romainl/idiomatic-vimrc
" https://gist.github.com/romainl/4b9f139d2a8694612b924322de1025ce
" https://github.com/zenbro/dotfiles/blob/master/.nvimrc
" https://github.com/spf13/spf13-vim/blob/3.0/.vimrc
" https://github.com/euclio/vimrc/blob/master/vimrc
" https://github.com/KevOBrien/dotfiles
" https://bitbucket.org/sjl/dotfiles/src/28205343c464b44fd36970d2588a74183ff73299/vim/vimrc

" }}}

" vim: set et ts=4 sw=4 sts=0 tw=80 fdm=marker:
