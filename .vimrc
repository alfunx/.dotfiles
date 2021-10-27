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
Plug '/usr/bin/fzf'

" General
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
"Plug 'Konfekt/vim-CtrlXA'
Plug 'justinmk/vim-dirvish'
"Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
"Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
"Plug 'tpope/vim-jdaddy'
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
"Plug 'windwp/nvim-autopairs'
Plug 'ap/vim-css-color'
Plug 'editorconfig/editorconfig-vim'
"Plug 'romainl/vim-qf'  " forked
Plug 'rhysd/git-messenger.vim'
Plug 'lambdalisue/suda.vim'

" Sidebars
Plug 'mbbill/undotree'
Plug 'majutsushi/tagbar'

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
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }
    Plug 'ray-x/lsp_signature.nvim'
else
    Plug 'autozimu/LanguageClient-neovim', {
                \ 'branch': 'next',
                \ 'do': 'bash install.sh',
                \ }
endif

" Language specific
Plug 'plasticboy/vim-markdown'  ", { 'for': 'markdown' }
Plug 'lervag/vimtex'  ", { 'for': ['latex', 'tex'] }
Plug 'neovimhaskell/haskell-vim'  ", { 'for': 'haskell' }
Plug 'tweekmonster/helpful.vim'  ", { 'for': ['vim', 'help'] }
Plug 'jupyter-vim/jupyter-vim'  ", { 'for': 'python' }

" Syntax
Plug 'cespare/vim-toml'

" Themes
"Plug 'morhetz/gruvbox'  "forked
"Plug 'lifepillar/vim-gruvbox8'

" Don't load in console
if &term !=? 'linux' || has('gui_running')
    "Plug 'vim-airline/vim-airline'
    Plug 'itchyny/lightline.vim'
endif

let g:plug_url_format = 'git@github.com:%s.git'

" Forked
Plug 'alfunx/tcomment_vim'  " fork of 'tomtom/tcomment_vim'
Plug 'alfunx/diffconflicts'  " fork of 'whiteinge/diffconflicts'
"Plug 'alfunx/vim-qf'  " fork of 'romainl/vim-qf'
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

augroup quick_fix_highlighting
    autocmd!
    autocmd ColorScheme * hi! QuickFixLine term=bold cterm=bold gui=bold
    autocmd ColorScheme * hi! link qfFileName Special
augroup END

augroup markdown_fence_highlighting
    autocmd!
    autocmd ColorScheme * hi! link mkdCodeStart Comment
    autocmd ColorScheme * hi! link mkdCodeEnd Comment
    autocmd ColorScheme * hi! link mkdCodeDelimiter Comment
augroup END

augroup conflict_marker_highlighting
    autocmd!
    autocmd ColorScheme * hi! link VcsConflict Error
    autocmd BufEnter,WinEnter * match VcsConflict '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$'
augroup END

augroup lsp_reference_highlighting
    autocmd!
    autocmd ColorScheme * hi! LspReferenceText  cterm=bold gui=bold
    autocmd ColorScheme * hi! LspReferenceRead  cterm=bold gui=bold
    autocmd ColorScheme * hi! LspReferenceWrite cterm=bold gui=bold
augroup END

augroup lsp_diagnostics_highlighting
    autocmd!
    autocmd ColorScheme * hi! link LspDiagnosticsDefaultError         TextError
    autocmd ColorScheme * hi! link LspDiagnosticsDefaultWarning       TextWarning
    autocmd ColorScheme * hi! link LspDiagnosticsDefaultInformation   TextInfo
    autocmd ColorScheme * hi! link LspDiagnosticsDefaultHint          TextHint
    autocmd ColorScheme * hi! link LspDiagnosticsUnderlineError       UnderlineError
    autocmd ColorScheme * hi! link LspDiagnosticsUnderlineWarning     UnderlineWarning
    autocmd ColorScheme * hi! link LspDiagnosticsUnderlineInformation UnderlineInfo
    autocmd ColorScheme * hi! link LspDiagnosticsUnderlineHint        UnderlineHint
augroup END

augroup lsp_hover_highlighting
    autocmd!
    autocmd ColorScheme * hi! link mkdLineBreak NONE
augroup END

augroup status_line_update
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

" Mappings {{{

" Leader key
nnoremap <Space> <Nop>
nnoremap <CR> <Nop>
let mapleader = ' '
let maplocalleader = ''

" Split navigation
if exists(':TmuxNavigate')
    let g:tmux_navigator_no_mappings = 1
    nnoremap <silent> <C-h>  :<C-u>TmuxNavigateLeft<CR>
    nnoremap <silent> <C-j>  :<C-u>TmuxNavigateDown<CR>
    nnoremap <silent> <C-k>  :<C-u>TmuxNavigateUp<CR>
    nnoremap <silent> <C-l>  :<C-u>TmuxNavigateRight<CR>
    nnoremap <silent> <C-BS> :<C-u>TmuxNavigatePrevious<CR>
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
nnoremap <silent> <C-w><C-t> :tab split<CR>

" Close tab
nnoremap <silent> <C-w>b     :bd<CR>
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
xnoremap <silent> gy "+y
nnoremap <silent> gY "+Y
xnoremap <silent> gY "+Y
nnoremap <silent> gp "+p
xnoremap <silent> gp "+p
nnoremap <silent> gP "+P
xnoremap <silent> gP "+P

" Keep selection after indenting
xnoremap <silent> < <gv
xnoremap <silent> > >gv

" Swap lines
nnoremap <silent> <leader>j :m .+1<CR>
nnoremap <silent> <leader>k :m .-2<CR>
xnoremap <silent> <leader>j :m '>+1<CR>gv=gv
xnoremap <silent> <leader>k :m '<-2<CR>gv=gv

" Use CTRL-S for saving, also in Insert mode
nnoremap <silent> <C-s>      :<C-u>write<CR>
xnoremap <silent> <C-s> <Esc>:<C-u>write<CR>
inoremap <silent> <C-s> <C-o>:<C-u>write<CR><Esc>

" Exit terminal insert mode
tnoremap <Esc> <C-\><C-n>

" Insert mode mappings
inoremap <silent> <C-u> <C-g>u<C-u>
inoremap <silent> è     <C-o>O
inoremap <silent> à     <C-o>o
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

" Mark word, instead of jumping
nnoremap <silent> * :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hlsearch<CR>
nnoremap <silent> # :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hlsearch<CR>

" Move cursor by dipslay lines when wrapping
nnoremap <expr> j v:count \|\| !&wrap ? 'j' : 'gj'
xnoremap <expr> j v:count \|\| !&wrap ? 'j' : 'gj'
onoremap <expr> j v:count \|\| !&wrap ? 'j' : 'gj'
nnoremap <expr> k v:count \|\| !&wrap ? 'k' : 'gk'
xnoremap <expr> k v:count \|\| !&wrap ? 'k' : 'gk'
onoremap <expr> k v:count \|\| !&wrap ? 'k' : 'gk'

nnoremap <expr> gj v:count \|\| !&wrap ? 'gj' : 'j'
xnoremap <expr> gj v:count \|\| !&wrap ? 'gj' : 'j'
onoremap <expr> gj v:count \|\| !&wrap ? 'gj' : 'j'
nnoremap <expr> gk v:count \|\| !&wrap ? 'gk' : 'k'
xnoremap <expr> gk v:count \|\| !&wrap ? 'gk' : 'k'
onoremap <expr> gk v:count \|\| !&wrap ? 'gk' : 'k'

nnoremap <expr> 0 v:count \|\| !&wrap ? '0' : 'g0'
xnoremap <expr> 0 v:count \|\| !&wrap ? '0' : 'g0'
onoremap <expr> 0 v:count \|\| !&wrap ? '0' : 'g0'
nnoremap <expr> ^ v:count \|\| !&wrap ? '^' : 'g^'
xnoremap <expr> ^ v:count \|\| !&wrap ? '^' : 'g^'
onoremap <expr> ^ v:count \|\| !&wrap ? '^' : 'g^'
nnoremap <expr> $ v:count \|\| !&wrap ? '$' : 'g$'
xnoremap <expr> $ v:count \|\| !&wrap ? '$' : 'g$'
onoremap <expr> $ v:count \|\| !&wrap ? '$' : 'g$'

nnoremap <expr> g0 v:count \|\| !&wrap ? 'g0' : '0'
xnoremap <expr> g0 v:count \|\| !&wrap ? 'g0' : '0'
onoremap <expr> g0 v:count \|\| !&wrap ? 'g0' : '0'
nnoremap <expr> g^ v:count \|\| !&wrap ? 'g^' : '^'
xnoremap <expr> g^ v:count \|\| !&wrap ? 'g^' : '^'
onoremap <expr> g^ v:count \|\| !&wrap ? 'g^' : '^'
nnoremap <expr> g$ v:count \|\| !&wrap ? 'g$' : '$'
xnoremap <expr> g$ v:count \|\| !&wrap ? 'g$' : '$'
onoremap <expr> g$ v:count \|\| !&wrap ? 'g$' : '$'

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
nnoremap <silent> <M-0> :<C-u>tablast<CR>

" Diff update
nnoremap <silent> du :<C-u>diffupdate!<CR>

" German keyboard mappings
nmap <silent> ä  ^
xmap <silent> ä  ^
omap <silent> ä  ^
nmap <silent> gä g^
xmap <silent> gä g^
omap <silent> gä g^
nmap <silent> ö  "
xmap <silent> ö  "
omap <silent> ö  "
nmap <silent> ü  [
xmap <silent> ü  [
omap <silent> ü  [
nmap <silent> ¨  ]
xmap <silent> ¨  ]
omap <silent> ¨  ]
nmap <silent> üü [[
xmap <silent> üü [[
omap <silent> üü [[
nmap <silent> ü¨ []
xmap <silent> ü¨ []
omap <silent> ü¨ []
nmap <silent> ¨ü ][
xmap <silent> ¨ü ][
omap <silent> ¨ü ][
nmap <silent> ¨¨ ]]
xmap <silent> ¨¨ ]]
omap <silent> ¨¨ ]]
nmap <silent> g¨ g]
xmap <silent> g¨ g]
omap <silent> g¨ g]

" Jump to definition
nmap <silent> è <C-]>
xmap <silent> è <C-]>

" Jump paragraphs
nmap <silent> <M-j> }
xmap <silent> <M-j> }
omap <silent> <M-j> }
nmap <silent> <M-k> {
xmap <silent> <M-k> {
omap <silent> <M-k> {

" Wildmenu
set wildchar=<Tab>
set wildcharm=<Tab>
cnoremap <expr> <Tab>   getcmdtype() =~ '[?/]' ? '<C-g>' : '<Tab>'
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? '<C-t>' : '<S-Tab>'

" Remove trailing whitespaces
nnoremap <silent> <F3> m`:<C-u>keeppatterns %s/\\\@1<!\s\+$//e<CR>``

" Allow saving of files as sudo
command! W exe 'silent! w !sudo /usr/bin/tee % >/dev/null' <Bar> edit!

" Set path to current file
command! -bang -nargs=* Cd cd<bang> %:p:h

" Compare buffer to file on disk
command! DiffOrig vnew | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" Set highlight
nnoremap <silent> <M-b> :<C-u>nohlsearch<CR>
nnoremap <silent> <M-v> :<C-u>set hlsearch<CR>

" Change register
nnoremap <silent> cx :<C-u>call functions#change_register()<CR>

" Run last macro
nnoremap Q @@

" Run macro on visual selection
nnoremap <silent> <leader>@ :set opfunc=opfunc#visual_macro<CR>g@
xnoremap <silent>         @ :<C-u>call opfunc#visual_macro(visualmode(), 1)<CR>

" Google
nnoremap <silent> <leader>? :set opfunc=opfunc#google<CR>g@
xnoremap <silent>         ? :<C-u>call opfunc#google(visualmode(), 1)<CR>

" Copy path:line
"nnoremap <silent> <F4> :<C-u>exe "!tmux send -t " . v:count . " 'b " . expand("%:p") . ":" . line(".") . "' C-m"<CR>
"nnoremap <silent> <F4> :<C-u>call system("tmux send -t monetDB:server 'b " . expand("%:p") . ":" . line(".") . "' C-m")<CR>
nnoremap <silent> <F4> :<C-u>let @+ = expand('%:p') . ':' . line('.')<CR>

" Display highlighting info
nnoremap <silent> <F10> :<C-u>call functions#echo_syntax()<CR>

" Grep
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

" Grep
command! -bang -nargs=+ -complete=file -bar Grep
            \ call grep#qf(<bang>0?'--pcre2':'', <f-args>)
command! -bang -nargs=+ -complete=file -bar Grepadd
            \ call grep#qfadd(<bang>0?'--pcre2':'', <f-args>)
command! -bang -nargs=+ -complete=file -bar LGrep
            \ call grep#ll(<bang>0?'--pcre2':'', <f-args>)
command! -bang -nargs=+ -complete=file -bar LGrepadd
            \ call grep#lladd(<bang>0?'--pcre2':'', <f-args>)

nnoremap <leader>s :<C-u>Grep<space>
nnoremap <leader>S :<C-u>Grepadd<space>

nnoremap <silent> gs :set opfunc=grep#qf_opfunc<CR>g@
xnoremap <silent> gs :<C-u>call grep#qf_opfunc(visualmode(), 1)<CR>

nnoremap <silent> gS :set opfunc=grep#qfadd_opfunc<CR>g@
xnoremap <silent> gS :<C-u>call grep#qfadd_opfunc(visualmode(), 1)<CR>

" Mappings for quickfix/loclist
nnoremap <silent> <Left>  :cprevious<CR>
nnoremap <silent> <Right> :cnext<CR>
nnoremap <silent> <Up>    :lprevious<CR>
nnoremap <silent> <Down>  :lnext<CR>

nnoremap <silent> <C-Left>  :cpfile<CR>
nnoremap <silent> <C-Right> :cnfile<CR>
nnoremap <silent> <C-Up>    :lpfile<CR>
nnoremap <silent> <C-Down>  :lnfile<CR>

nnoremap <silent> <leader><Left>  :colder<CR>
nnoremap <silent> <leader><Right> :cnewer<CR>
nnoremap <silent> <leader><Up>    :lolder<CR>
nnoremap <silent> <leader><Down>  :lnewer<CR>

nmap <silent> <leader>q :copen<CR>
nmap <silent> <leader>l :lopen<CR>

" Open quickfix/loclist window automatically
augroup auto_open_quickfix
    autocmd!
    autocmd QuickFixCmdPost cexpr,cgetexpr,caddexpr,cfile,cgetfile copen
    autocmd QuickFixCmdPost lexpr,lgetexpr,laddexpr,lfile,lgetfile lopen
augroup END

" GitBlame
command! -range GBlame echo functions#gitblame('<line1>,<line2>')

" Git diff locations
command! -bang -nargs=* -complete=file -bar GDiff
            \ GitGutterQuickFix | copen

" Git merge locations
command! -bang -nargs=* -complete=file -bar GMerge
            \ call git#qf('merge', <f-args>)

" Git diff --check locations
command! -bang -nargs=* -complete=file -bar GCheck
            \ call git#qf('check', <f-args>)

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
nnoremap <silent> <leader>f :<C-u>Files<CR>
nnoremap <silent> <leader>b :<C-u>Buffers<CR>
nnoremap <silent> <leader>w :<C-u>Windows<CR>

"" Mapping selecting mappings
nmap <leader><Tab> <plug>(fzf-maps-n)
xmap <leader><Tab> <plug>(fzf-maps-x)
omap <leader><Tab> <plug>(fzf-maps-o)

"" Insert mode completion
imap <C-x><C-k> <plug>(fzf-complete-word)
imap <C-x><C-f> <plug>(fzf-complete-path)
imap <C-x><C-j> <plug>(fzf-complete-file-ag)
imap <C-x><C-l> <plug>(fzf-complete-line)

"" Default key bindings
let g:fzf_action = {
            \ 'ctrl-t': 'tab split',
            \ 'ctrl-x': 'split',
            \ 'ctrl-v': 'vsplit' }

"" Default fzf layout
let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.6, 'border': 'sharp' } }
let $FZF_DEFAULT_OPTS .= ' --reverse'

"" Disable preview window
let g:fzf_preview_window = []

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
            \ 'border':  ['bg', 'FloatBorder'],
            \ 'prompt':  ['fg', 'Type'],
            \ 'pointer': ['fg', 'Type'],
            \ 'marker':  ['fg', 'Statement'],
            \ 'spinner': ['fg', 'LineNr'],
            \ 'header':  ['fg', 'Type'] }

"" Customize the options used by 'git log'
let g:fzf_commits_log_options = '--graph --color=always --pretty=lo'

"" Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" vim-gitgutter - special space: ( ) U+2000 (EN QUAD)
let g:gitgutter_sign_priority = 30
let g:gitgutter_sign_added = ' ┃'
let g:gitgutter_sign_modified = ' ┃'
let g:gitgutter_sign_removed = ' ◢'
let g:gitgutter_sign_removed_first_line = ' ◥'
let g:gitgutter_sign_modified_removed = '━┫'
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
xmap f <Plug>Sneak_f
nmap F <Plug>Sneak_F
xmap F <Plug>Sneak_F
nmap t <Plug>Sneak_t
xmap t <Plug>Sneak_t
nmap T <Plug>Sneak_T
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

" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" undotree
nnoremap <silent> <F11> :<C-u>UndotreeToggle<CR>

" tagbar
nnoremap <silent> <F12> :<C-u>TagbarToggle<CR>

" vim-after-object
augroup after_text_object
    autocmd!
    autocmd VimEnter * call after_object#enable(['n', 'nn'], '=', ':', '+', '-', '*', '/', '#', ' ')
augroup End

" vimtex
let g:tex_flavor = 'latex'
let g:vimtex_view_method = 'zathura'

" ultisnips
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<C-l>'
let g:UltiSnipsJumpBackwardTrigger = '<C-h>'
let g:UltiSnipsEditSplit = "vertical"

let g:snips_author = "Alphonse Mariya"
let g:snips_email = "alphonse.mariya@hotmail.com"
let g:snips_github = "https://github.com/alfunx"

inoremap <silent> <C-j> <C-r>=functions#expand_snippet()<CR>

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

" pear-tree
let g:pear_tree_smart_openers = 0
let g:pear_tree_smart_closers = 0
let g:pear_tree_smart_backspace = 0
imap <M-z> <Plug>(PearTreeJump)

" " nvim-autopairs
" lua <<EOF
" require'nvim-autopairs'.setup {
"     check_ts = true,
"     ts_config = {
"         java = false,
"         javascript = {'template_string'},
"         lua = {'string'},
"         -- rust = {'string'},
"     },
" }
" EOF

" git-messenger
let g:git_messenger_no_default_mappings = 1
nmap gb <Plug>(git-messenger)

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

" " vim-qf
" let g:qf_mapping_ack_style = 1
" let g:qf_bufname_or_text = 0
" let g:qf_shorten_path = 0
" let g:qf_auto_resize = 0
" let g:qf_auto_open_quickfix = 0
" let g:qf_auto_open_loclist = 0
" nmap <silent> [q <Plug>(qf_qf_previous)
" nmap <silent> ]q <Plug>(qf_qf_next)
" nmap <silent> [w <Plug>(qf_loc_previous)
" nmap <silent> ]w <Plug>(qf_loc_next)
" nmap <silent> <Left>    <Plug>(qf_qf_previous)
" nmap <silent> <Right>   <Plug>(qf_qf_next)
" nmap <silent> <Up>      <Plug>(qf_loc_previous)
" nmap <silent> <Down>    <Plug>(qf_loc_next)
" nmap <silent> <C-Left>  <Plug>(qf_older)
" nmap <silent> <C-Right> <Plug>(qf_newer)
" nmap <silent> <C-Up>    <Plug>(qf_previous_file)
" nmap <silent> <C-Down>  <Plug>(qf_next_file)
" nmap <silent> <leader>q        <Plug>(qf_qf_toggle_stay)
" nmap <silent> <leader>l        <Plug>(qf_loc_toggle_stay)
" nmap <silent> <leader><leader> <Plug>(qf_qf_switch)

" suda.vim
let g:suda_smart_edit = 1
let g:suda#prefix = ['sudo://', 'suda://']

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
            \ 'path': '%{expand("%:p:~:.:s?^$?./?")}',
            \ 'fileinfo': '%t%{status#fileinfo()}',
            \ 'lineinfo': '%3l/%L:%-2c',
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
            \ 'lsp_error': 'lsp#errors',
            \ 'lsp_warning': 'lsp#warnings',
            \ 'lsp_info': 'lsp#infos',
            \ 'lsp_hint': 'lsp#hints',
            \ }

let g:lightline.component_type = {
            \ 'lsp_error': 'error',
            \ 'lsp_warning': 'warning',
            \ 'lsp_info': 'info',
            \ 'lsp_hint': 'hint',
            \ }

let g:lightline.tab_component = {
            \ }

let g:lightline.tab_component_function = {
            \ 'readonly': 'status#tab_readonly',
            \ 'modified': 'status#tab_modified',
            \ 'tabnum': 'status#tab_tabnum',
            \ }

" }}}

" LSP / Linting {{{

if has('nvim')

    " special space: ( ) U+2000 (EN QUAD)
    sign define LspDiagnosticsSignError       text= ● texthl=TextError   linehl= numhl=
    sign define LspDiagnosticsSignWarning     text= ● texthl=TextWarning linehl= numhl=
    sign define LspDiagnosticsSignInformation text= ● texthl=TextInfo    linehl= numhl=
    sign define LspDiagnosticsSignHint        text= ● texthl=TextHint    linehl= numhl=

    lua <<EOF
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = {
            prefix = '←',
            spacing = 0,
        },
        signs = {
            priority = 20,
        },
        severity_sort = true,
    }
)
EOF

    lua <<EOF
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, {
        border = 'single',
    }
)
EOF

    lua <<EOF
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, {
        border = 'single',
    }
)
EOF

"     " display only most severe sign per line
"     lua <<EOF
" local set_signs = vim.lsp.diagnostic.set_signs
" vim.lsp.diagnostic.set_signs = function(diagnostics, bufnr, client_id, sign_ns, opts)
"     if not diagnostics then return end
"
"     local diagnostic = {}
"     for _, d in pairs(diagnostics) do
"         if not diagnostic[d.range.start.line]
"                 or d.severity < diagnostic[d.range.start.line].severity then
"             diagnostic[d.range.start.line] = d
"         end
"     end
"
"     local filtered_diagnostics = {}
"     for _, v in pairs(diagnostic) do
"         table.insert(filtered_diagnostics, v)
"     end
"
"     set_signs(filtered_diagnostics, bufnr, client_id, sign_ns, opts)
" end
" EOF

    " native language client
    let g:lsp_languages = ['bib', 'c', 'cpp', 'java', 'lua', 'objc', 'python', 'rust', 'sh', 'tex', 'vim']

    lua require'lspconfig'.bashls.setup{}
    lua require'lspconfig'.ccls.setup{}
    lua require'lspconfig'.gopls.setup{}
    lua require'lspconfig'.jdtls.setup{}
    lua require'lspconfig'.pylsp.setup{}
    lua require'lspconfig'.rust_analyzer.setup{}
    lua require'lspconfig'.sumneko_lua.setup{cmd={"lua-language-server"}}
    lua require'lspconfig'.texlab.setup{}
    lua require'lspconfig'.vimls.setup{}

    function! LSP_settings()
        if empty(filter(g:lsp_languages, 'v:key != &filetype')) | return | endif
        nnoremap <buffer><silent> <leader>K  K
        nnoremap <buffer><silent> K          <Cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap <buffer><silent> <F1>       <Cmd>lua vim.lsp.buf.signature_help()<CR>
        inoremap <buffer><silent> <C-k>      <Cmd>lua vim.lsp.buf.signature_help()<CR>
        inoremap <buffer><silent> <F1>       <Cmd>lua vim.lsp.buf.signature_help()<CR>

        nnoremap <buffer><silent> <leader>d  <Cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <buffer><silent> <leader>D  <Cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <buffer><silent> <leader>t  <Cmd>lua vim.lsp.buf.type_definition()<CR>
        nnoremap <buffer><silent> <leader>i  <Cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap <buffer><silent> <leader>r  <Cmd>lua vim.lsp.buf.references()<CR>
        nnoremap <buffer><silent> <leader>gi <Cmd>lua vim.lsp.buf.incoming_calls()<CR>
        nnoremap <buffer><silent> <leader>go <Cmd>lua vim.lsp.buf.outgoing_calls()<CR>
        nnoremap <buffer><silent> <leader>gs <Cmd>lua vim.lsp.buf.workspace_symbols()<CR>

        nnoremap <buffer><silent> <leader>x  <Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>
        nnoremap <buffer><silent> <leader>X  <Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>
        nnoremap <buffer><silent> <leader>gx <Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>

        nnoremap <buffer><silent> <leader>u  <Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>
        nnoremap <buffer><silent> <leader>U  <Cmd>lua vim.lsp.diagnostic.set_loclist{open_loclist=false}<CR>

        nnoremap <buffer><silent> <leader>c  <Cmd>lua vim.lsp.buf.rename()<CR>
        nnoremap <buffer><silent> <M-CR>     <Cmd>lua vim.lsp.buf.code_action()<CR>
        xnoremap <buffer><silent> <M-CR>     <Cmd>lua vim.lsp.buf.range_code_action()<CR>
    endfunction

    augroup lsp_config
        autocmd!
        autocmd FileType * call LSP_settings()
        autocmd FileType * set omnifunc=v:lua.vim.lsp.omnifunc
        autocmd User LspDiagnosticsChanged lua vim.lsp.diagnostic.set_loclist{open_loclist=false}
        autocmd User LspDiagnosticsChanged call lightline#update()
    augroup END

    " lightline
    let g:lightline.component_expand['lsp_error']   = 'lsp#errors'
    let g:lightline.component_expand['lsp_warning'] = 'lsp#warnings'
    let g:lightline.component_expand['lsp_info']    = 'lsp#infos'
    let g:lightline.component_expand['lsp_hint']    = 'lsp#hints'

else

    " LanguageClient
    let g:LanguageClient_autoStart = 1
    let g:LanguageClient_selectionUI = 'quickfix'
    let g:LanguageClient_diagnosticsList = 'Location'
    let g:LanguageClient_diagnosticsMaxSeverity = 'Hint'
    let g:LanguageClient_hoverPreview = 'Always'
    let g:LanguageClient_virtualTextPrefix = ' ← '
    let g:LanguageClient_useVirtualText = 'All'
    let g:LanguageClient_hasSnippetSupport = 1

    let g:LanguageClient_serverCommands = {
                \ 'bib':     ['texlab'],
                \ 'c':       ['ccls'],
                \ 'cpp':     ['ccls'],
                \ 'java':    ['jdtls'],
                \ 'lua':     ['lua-lsp'],
                \ 'objc':    ['ccls'],
                \ 'python':  ['pyls'],
                \ 'rust':    ['rust-analyzer'],
                \ 'sh':      ['bash-language-server', 'start'],
                \ 'tex':     ['texlab'],
                \ 'vim':     ['vim-language-server', '--stdio'],
                \ }

    let g:LanguageClient_diagnosticsDisplay = {
                \     1: {
                \         "name": "Error",
                \         "texthl": "ALEError",
                \         "signText": "●",
                \         "signTexthl": "ALEErrorSign",
                \         "virtualTexthl": "TextError",
                \     },
                \     2: {
                \         "name": "Warning",
                \         "texthl": "ALEWarning",
                \         "signText": "●",
                \         "signTexthl": "ALEWarningSign",
                \         "virtualTexthl": "TextWarning",
                \     },
                \     3: {
                \         "name": "Information",
                \         "texthl": "ALEInfo",
                \         "signText": "●",
                \         "signTexthl": "ALEInfoSign",
                \         "virtualTexthl": "TextInfo",
                \     },
                \     4: {
                \         "name": "Hint",
                \         "texthl": "ALEHint",
                \         "signText": "●",
                \         "signTexthl": "ALEHintSign",
                \         "virtualTexthl": "TextHint",
                \     },
                \ }

    function! LanguageClient_settings()
        if !has_key(g:LanguageClient_serverCommands, &filetype) | return | endif
        nnoremap <buffer><silent> <leader>K  K
        nnoremap <buffer><silent> K          :<C-u>call LanguageClient_textDocument_hover()<CR>
        nnoremap <buffer><silent> <F1>       :<C-u>call LanguageClient_contextMenu()<CR>
        inoremap <buffer><silent> <C-k>      :<C-u>call LanguageClient_textDocument_hover()<CR>
        inoremap <buffer><silent> <F1>       :<C-u>call LanguageClient_contextMenu()<CR>

        nnoremap <buffer><silent> <leader>d  :<C-u>call LanguageClient_textDocument_definition()<CR>
        nnoremap <buffer><silent> <leader>t  :<C-u>call LanguageClient_textDocument_typeDefinition()<CR>
        nnoremap <buffer><silent> <leader>i  :<C-u>call LanguageClient_textDocument_implementation()<CR>
        nnoremap <buffer><silent> <leader>r  :<C-u>call LanguageClient_textDocument_references()<CR>
        nnoremap <buffer><silent> <leader>gd :<C-u>call LanguageClient_textDocument_documentSymbol()<CR>
        nnoremap <buffer><silent> <leader>gs :<C-u>call LanguageClient_workspace_symbol()<CR>

        nnoremap <buffer><silent> <leader>c  :<C-u>call LanguageClient_textDocument_rename()<CR>
        nnoremap <buffer><silent> <M-CR>     :<C-u>call LanguageClient_handleCodeLensAction()<CR>
        xnoremap <buffer><silent> <M-CR>     :<C-u>call LanguageClient_handleCodeLensAction()<CR>
    endfunction

    augroup language_client_config
        autocmd!
        autocmd FileType * call LanguageClient_settings()
        autocmd User LanguageClientDiagnosticsChanged call lightline#update()
    augroup END

    " lightline
    let g:lightline.component_expand['lsp_error']   = 'languageclient#errors'
    let g:lightline.component_expand['lsp_warning'] = 'languageclient#warnings'
    let g:lightline.component_expand['lsp_info']    = 'languageclient#infos'
    let g:lightline.component_expand['lsp_hint']    = 'languageclient#hints'

endif

if has('nvim')

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = { "bash", "c", "cpp", "go", "java", "latex", "lua", "python", "rust", "vim" },
    ignore_install = { },
    highlight = {
        enable = false,
        additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
        enable = false,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },
}
EOF

endif

if has('nvim')

lua <<EOF
require'lsp_signature'.setup {
    bind = true,
    doc_lines = 10,
    floating_window = true,
    floating_window_above_cur_line = true,
    fix_pos = true,
    hint_enable = false,
    hint_prefix = "↑ ",
    hint_scheme = "String",
    use_lspsaga = false,
    hi_parameter = "SpellBad",
    max_height = 12,
    max_width = 120,
    transpancy = nil,
    handler_opts = { border = "none" },
    always_trigger = false,
    auto_close_after = nil,
    extra_trigger_chars = { "(", "," },
    zindex = 200,
    padding = '',
    timer_interval = 200,
    toggle_key = nil,
}
EOF

endif

" }}}

" Settings {{{

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
set updatetime=400

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smarttab
set textwidth=80
set scrolloff=3
set sidescroll=1
set sidescrolloff=0

set wildmode=longest:full,full
set wildignorecase
set wildignore+=*/.ccls-cache,*/.clangd
set wildignore+=*.o,*.so,*.class,*.exe,*.dll,*.com
set wildignore+=tags,.tags,*/.backup,*/.vim-backup,*/.swap,*/.vim-swap,*/.undo,*/.vim-undo,*/._pkg
set wildignore+=*.cache,*.log,*~,*#,*.bak,*.BAK,*.old,*.OLD,*.off,*.OFF,*.dist,*.DIST,*.orig,*.ORIG,*.rej,*.REJ,.DS_Store*
set wildignore+=*.swp,*.swo,*.swn,*.swm,*.tmp
set wildignore+=*.pid,*.state
set wildignore+=*.dump,*.stackdump,*.zcompdump,*.zwc,*.pcap,*.cap,*.dmp
set wildignore+=*.err,*.error,*.stderr
set wildignore+=*_rsa,*_rsa.*,*_dsa,*_dsa.*,*_keys,*.pem,*.key,*.gpg

set complete-=i
set completeopt=menuone,noinsert,noselect
set shortmess+=aIc shortmess-=S
set diffopt+=hiddenoff,algorithm:histogram
set formatoptions-=o
set nrformats-=octal
set pastetoggle=<F2>
set signcolumn=yes
set history=10000
set sessionoptions-=options
set nojoinspaces
set belloff=all
set lazyredraw
set synmaxcol=800
set dictionary+=/usr/share/dict/american-english
set tags^=./.git/tags
set foldtext=functions#foldtext()

set guifont=monospace
set guioptions-=mTrl

if &term !=? 'linux' || has('gui_running')
    "set listchars=tab:›\ ,extends:›,precedes:‹,nbsp:˷,eol:⤶,trail:~
    set showbreak=→\ \ \ 
    set listchars=tab:›\ ,extends:…,precedes:…,nbsp:␣,trail:·
    set fillchars=vert:│,fold:─,diff:\ 
else
    "set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,eol:$,trail:~
    set listchars=tab:>\ ,extends:…,precedes:…,nbsp:+,trail:~
    set showbreak=\\\ \ \ 
    set fillchars=vert:\|,fold:-,diff:\ 
endif

" }}}

" Autocmd {{{

augroup source_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END

augroup git_gutter_update
    autocmd!
    autocmd BufWritePost * GitGutter
augroup END

augroup unfold_initially
    autocmd!
    autocmd BufWinEnter * let &foldlevel=max(add(map(range(1, line('$')), 'foldlevel(v:val)'), 10))
augroup End

augroup dirvish_conceal
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

    augroup restore_position
        autocmd!
        autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") &&
                    \ index(['gitcommit', 'gitrebase'], &ft) < 0 |
                    \ exe 'normal! g`"zvzz' |
                    \ endif
    augroup End
endif

if has('nvim')
    augroup yank_highlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank {on_visual=false,timeout=150}
    augroup END
endif

if !has('nvim')
    set display=lastline
    set viminfo=%,\"800,'10,/50,:100,h,f0,n~/.vim/.viminfo
    set switchbuf+=uselast
endif

if has('nvim')
    augroup close_fzf_window
        autocmd!
        autocmd TermLeave * call functions#close_if_fzf()
    augroup END
endif

" }}}

" Backup / Swap / Undo {{{

if has('nvim')

    if !isdirectory($HOME . '/.local/share/nvim/backup')
        silent !mkdir -p ~/.local/share/nvim/backup >/dev/null 2>&1
    endif
    set backupdir-=.
    set backupdir+=.
    set backupdir^=~/.local/share/nvim/backup//
    set backupdir^=./.nvim-backup//
    set backup

    if !isdirectory($HOME . '/.local/share/nvim/swap')
        silent !mkdir -p ~/.local/share/nvim/swap >/dev/null 2>&1
    endif
    set directory-=.
    set directory+=.
    set directory^=~/.local/share/nvim/swap//
    set directory^=./.nvim-swap//

    if !isdirectory($HOME . '/.local/share/nvim/undo')
        silent !mkdir -p ~/.local/share/nvim/undo >/dev/null 2>&1
    endif
    set undodir^=~/.local/share/nvim/undo//
    set undodir^=./.nvim-undo//
    set undofile

else

    if !isdirectory($HOME . '/.vim/.backup')
        silent !mkdir -p ~/.vim/.backup >/dev/null 2>&1
    endif
    set backupdir-=.
    set backupdir+=.
    set backupdir^=~/.vim/.backup//
    set backupdir^=./.vim-backup//
    set backup

    if !isdirectory($HOME . '/.vim/.swap')
        silent !mkdir -p ~/.vim/.swap >/dev/null 2>&1
    endif
    set directory-=.
    set directory+=.
    set directory^=~/.vim/.swap//
    set directory^=./.vim-swap//

    if !isdirectory($HOME . '/.vim/.undo')
        silent !mkdir -p ~/.vim/.undo >/dev/null 2>&1
    endif
    set undodir^=~/.vim/.undo//
    set undodir^=./.vim-undo//
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
