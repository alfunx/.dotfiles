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

" If fzf is not available in the package manager
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" If fzf is installed through the package manager
Plug '/usr/bin/fzf'

" General
"Plug 'junegunn/fzf.vim'
Plug 'alfunx/fzf.vim'  " fork
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
"Plug 'tpope/vim-sensible'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'whiteinge/diffconflicts'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'mhinz/vim-grepper'
Plug 'terryma/vim-multiple-cursors'
"Plug 'terryma/vim-expand-region'
Plug 'jiangmiao/auto-pairs'
"Plug 'Raimondi/delimitMate'
Plug 'mbbill/undotree'
"Plug 'christoomey/vim-titlecase'
Plug 'tomtom/tcomment_vim'
Plug 'ap/vim-css-color'
"Plug 'jceb/vim-orgmode'
Plug 'xtal8/traces.vim'
Plug 'chrisbra/NrrwRgn'
"Plug 'kopischke/vim-fetch'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
"Plug 'ludovicchabant/vim-gutentags'

" Text objects
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-after-object'
"Plug 'michaeljsmith/vim-indent-object'
Plug 'alfunx/vim-indent-object'  " fork
Plug 'kana/vim-textobj-user'
"Plug 'kana/vim-textobj-entire'
Plug 'Julian/vim-textobj-variable-segment'

" Completion
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

" Tmux
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'
Plug 'wellle/tmux-complete.vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" " Language server
" Plug 'autozimu/LanguageClient-neovim', {
"             \ 'branch': 'next',
"             \ 'do': 'bash install.sh',
"             \ }

" Language specific
Plug 'editorconfig/editorconfig-vim'
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'zchee/deoplete-clang'

" Themes
"Plug 'morhetz/gruvbox'
Plug 'alfunx/gruvbox'  " fork

" Don't load in console
if &term !=? 'linux' || has('gui_running')
    Plug 'vim-airline/vim-airline'
endif

call plug#end()

runtime ftplugin/man.vim
runtime ftplugin/vim.vim
runtime ftplugin/help.vim
runtime macros/matchit.vim


""""""""""""""""""
"  KEY MAPPINGS  "
""""""""""""""""""

"" Leader key
nnoremap <Space> <Nop>
nnoremap <CR> <Nop>
let mapleader=' '
let maplocalleader=''

"" Split navigation
"nnoremap <C-h> <C-w><C-h>
"nnoremap <C-j> <C-w><C-j>
"nnoremap <C-k> <C-w><C-k>
"nnoremap <C-l> <C-w><C-l>

"" Split navigation (vim-tmux-navigator)
let g:tmux_navigator_no_mappings=1
nnoremap <silent> <C-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <C-j> :TmuxNavigateDown<CR>
nnoremap <silent> <C-k> :TmuxNavigateUp<CR>
nnoremap <silent> <C-l> :TmuxNavigateRight<CR>
nnoremap <silent> <C-BS> :TmuxNavigatePrevious<CR>

"" Split resize
nnoremap <silent> <C-w>h 5<C-w><
nnoremap <silent> <C-w>j 5<C-w>-
nnoremap <silent> <C-w>k 5<C-w>+
nnoremap <silent> <C-w>l 5<C-w>>

"" New tab
nnoremap <silent> <C-w>t :tabedit<CR>
nnoremap <silent> <C-w><C-t> :tabedit<CR>

"" Tab navigation
nnoremap <silent> <C-w><C-h> :tabprevious<CR>
nnoremap <silent> <C-w><C-l> :tabnext<CR>

"" Fullscreen
nnoremap <silent> <C-w>F <C-w>_<C-w><Bar>

"nnoremap <silent> <Home> <C-w><
"nnoremap <silent> <PageDown> <C-w>-
"nnoremap <silent> <PageUp> <C-w>+
"nnoremap <silent> <End> <C-w>>

"augroup Quickfix
"  autocmd!
"  autocmd QuickFixCmdPost [^l]* cwindow
"  autocmd QuickFixCmdPost l*        lwindow
"augroup END

" German keyboard mappings
nmap ä ^
xmap ä ^
omap ä ^
nmap ö "
xmap ö "
omap ö "

nmap ü [
xmap ü [
omap ü [
nmap ¨ ]
xmap ¨ ]
omap ¨ ]

nnoremap è <C-]>
xnoremap è <C-]>

execute "set <M-h>=\<Esc>h"
execute "set <M-j>=\<Esc>j"
execute "set <M-k>=\<Esc>k"
execute "set <M-l>=\<Esc>l"
nnoremap <M-j> }
xnoremap <M-j> }
onoremap <M-j> }
nnoremap <M-k> {
xnoremap <M-k> {
onoremap <M-k> {

" Make Y behave like other commands
nnoremap Y y$

" Copy to system clipboard
nnoremap gy "+y
nnoremap gp "+p
xnoremap gy "+y
xnoremap gp "+p

" Keep selection after indenting
xnoremap < <gv
xnoremap > >gv

" Swap lines
xnoremap <leader>j :m '>+1<CR>gv=gv
xnoremap <leader>k :m '<-2<CR>gv=gv
nnoremap <leader>j :m .+1<CR>
nnoremap <leader>k :m .-2<CR>

" Use CTRL-S for saving, also in Insert mode
nnoremap <silent> <C-s> :write<CR>
xnoremap <silent> <C-s> <Esc>:write<CR>
inoremap <silent> <C-s> <C-o>:write<CR><Esc>

"" Quickfix & Loclist
nnoremap <silent> <leader>q :copen<CR>
nnoremap <silent> <leader>l :lopen<CR>

"" Insert mode mappings
inoremap <C-u> <C-g>u<C-u>
inoremap àà <C-o>O
inoremap éé <C-o>o

" Select last inserted text
nnoremap gV `[v`]

" Move cursor by dipslay lines when wrapping
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
xnoremap <expr> j v:count ? 'j' : 'gj'
xnoremap <expr> k v:count ? 'k' : 'gk'

" Go to tab
execute "set <M-1>=\<Esc>1"
execute "set <M-2>=\<Esc>2"
execute "set <M-3>=\<Esc>3"
execute "set <M-4>=\<Esc>4"
execute "set <M-5>=\<Esc>5"
execute "set <M-6>=\<Esc>6"
execute "set <M-7>=\<Esc>7"
execute "set <M-8>=\<Esc>8"
execute "set <M-9>=\<Esc>9"
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> :tablast<CR>

" Magic regex search
noremap <leader>/ /\v
noremap <leader>? ?\v
set wildchar=<Tab>
set wildcharm=<Tab>
cnoremap <expr> <Tab> getcmdtype() =~ '[?/]' ? '<C-g>' : '<Tab>'
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? '<C-t>' : feedkeys('<S-Tab>', 'int')[1]

" Remove trailing whitespaces
nnoremap <silent> <F3> mz:keepp %s/\\\@1<!\s\+$//e<CR>`z

" Allow saving of files as sudo
command! W execute 'silent! w !sudo /usr/bin/tee % >/dev/null' <bar> edit!

" Set path to current file
command! -bang -nargs=* Cd  cd %:p:h
nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

" Run macro on visual selection
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Run last macro
nnoremap Q @@

" No highlight
execute "set <M-b>=\<Esc>b"
nnoremap <silent> <M-b> :<C-u>nohlsearch<CR>

" Change register
function! ChangeReg() abort
    let x = nr2char(getchar())
    call feedkeys("q:ilet @" . x . " = \<c-r>\<c-r>=string(@" . x . ")\<CR>\<esc>$", 'n')
endfunction
nnoremap cr :call ChangeReg()<CR>

" Diff update
nnoremap <silent> du :windo diffupdate<CR>


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

" Customize the options used by 'git log'
let g:fzf_commits_log_options='--graph --color=always --format="%c(auto)%h%d %s %c(black)%c(bold)%cr"'

" Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
"imap <leader><tab> <plug>(fzf-maps-i)

"" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>t :Tags<CR>

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Use custom dictionary
inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words-insane')

"" RG
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \ 'rg --hidden --line-number --column --no-heading --smart-case --follow --color=always --colors="match:none" --colors="path:fg:white" --colors="line:fg:white" '.shellescape(<q-args>), 1,
            \ <bang>0)

"" AG
command! -bang -nargs=* Ag
            \ call fzf#vim#ag(
            \ <q-args>, '--color-path "0;37" --color-line-number "0;37" --color-match "" --hidden --smart-case --follow',
            \ <bang>0)

if executable('rg')
    augroup Rg
        autocmd!
        autocmd VimEnter * nnoremap <Leader>r :Rg<CR>
    augroup End
elseif executable('ag')
    augroup Ag
        autocmd!
        autocmd VimEnter * nnoremap <Leader>r :Ag<CR>
    augroup End
endif

if executable('rg')
    set grepprg=rg\ --smart-case\ --vimgrep
    set grepformat^=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --smart-case\ --vimgrep
    set grepformat^=%f:%l:%c:%m
endif

"" Grepper
let g:grepper={}
let g:grepper.tools=[]
if executable('rg')
    let g:grepper.tools+=['rg']
elseif executable('ag')
    let g:grepper.tools+=['ag']
endif
let g:grepper.tools+=['git', 'grep']
let g:grepper.rg = {
            \ 'grepprg':        'rg --vimgrep',
            \ 'grepformat': '%f:%l:%c:%m',
            \ 'escape':         '\^$.*+?()[]{}|'
            \ }
let g:grepper.next_tool='<C-g>'
let g:grepper.jump=0
let g:grepper.quickfix=1
let g:grepper.dir='repo,cwd'
let g:grepper.stop=500

nnoremap <leader>s :Grepper -tool rg<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

command! Todo :Grepper -tool rg -query '(TODO|FIXME|BUG)'
command! Note :Grepper -tool rg -query '(NOTE)'

"" Airline
if !exists('g:airline_symbols')
    let g:airline_symbols={}
endif

""" Unicode symbols
let g:airline_left_alt_sep='»'
let g:airline_left_sep='▶'
let g:airline_right_alt_sep='«'
let g:airline_right_sep='◀'
let g:airline_symbols.crypt='🔒'
let g:airline_symbols.linenr='☰'
let g:airline_symbols.linenr='␊'
let g:airline_symbols.linenr='␤'
let g:airline_symbols.linenr='¶'
let g:airline_symbols.maxlinenr='␤'
let g:airline_symbols.branch='⎇'
let g:airline_symbols.paste='ρ'
let g:airline_symbols.paste='Þ'
let g:airline_symbols.paste='∥'
let g:airline_symbols.spell='Ꞩ'
let g:airline_symbols.notexists='∄'
let g:airline_symbols.whitespace='Ξ'

""" Powerline    
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''

" """ Straight ▌ │ ▐ │ or ▌ ▏ ▐ ▕
" let g:airline_left_sep='▌'
" let g:airline_left_alt_sep='│'
" let g:airline_right_sep='▐'
" let g:airline_right_alt_sep='│'

""" Powerline symbols
let g:airline_symbols.branch=''
let g:airline_symbols.readonly=''
let g:airline_symbols.linenr='☰'
let g:airline_symbols.maxlinenr=''

""" Airline settings
let g:airline_theme='gruvbox'
let g:airline#extensions#whitespace#mixed_indent_algo=1
let g:airline_powerline_fonts=1
let g:airline_skip_empty_sections=0
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#buffer_idx_mode=1
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#tabline#show_tab_nr=0
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#exclude_preview=1
let g:airline#extensions#tabline#fnamecollapse=1
let g:airline#extensions#tabline#fnamemod=':~:.'
let g:airline#extensions#tabline#buffers_label='buffers'
let g:airline#extensions#tabline#tabs_label='tabs'
let g:airline#extensions#tabline#overflow_marker='…'
let g:airline_section_z='%3p%% %3l:%-2v'

" let g:airline_mode_map = {
"             \ '__' : ' - ',
"             \ 'n'  : ' N ',
"             \ 'i'  : ' I ',
"             \ 'R'  : ' R ',
"             \ 'c'  : ' C ',
"             \ 'v'  : ' V ',
"             \ 'V'  : 'V-L',
"             \ '' : 'V-B',
"             \ 's'  : ' S ',
"             \ 'S'  : ' S ',
"             \ '' : ' S ',
"             \ }

""" Airline extensions
let g:airline#extensions#ale#error_symbol=''
let g:airline#extensions#ale#warning_symbol=''
let g:airline#extensions#ale#show_line_numbers=0
let g:airline#extensions#whitespace#show_message=1
let g:airline#extensions#hunks#enabled=0

"" GitGutter
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

"" EasyMotion
"let g:EasyMotion_do_mapping=0  " Disable default mappings
let g:EasyMotion_smartcase=1  " Turn on case insensitive feature
let g:EasyMotion_keys='asdghklqwertyuiopzxcvbnmfj,'

"nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
"map <Leader>j <Plug>(easymotion-j)
"map <Leader>k <Plug>(easymotion-k)

"" Incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

let g:incsearch#magic='\v'
let g:incsearch#smart_backward_word=1
let g:incsearch#consistent_n_direction=1
let g:incsearch#auto_nohlsearch=0
let g:incsearch#no_inc_hlsearch=1
let g:incsearch#highlight={
            \       'match' : {
            \           'priority' : '10'
            \       },
            \       'on_cursor' : {
            \           'priority' : '100'
            \       },
            \       'cursor' : {
            \           'group' : 'ErrorMsg',
            \           'priority' : '1000'
            \       }
            \ }

"" Incsearch-EasyMotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
"map zg/ <Plug>(incsearch-easymotion-stay)

"" Netrw
let g:netrw_liststyle=0
let g:netrw_preview=1

"" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"" Undotree
nnoremap <silent> <F4> :UndotreeToggle<CR>

"" Tagbar
nnoremap <silent> <F5> :TagbarToggle<CR>

" "" Titlecase
" let g:titlecase_map_keys=0
" nmap gwt <Plug>Titlecase
" xmap gwt <Plug>Titlecase
" nmap gwT <Plug>TitlecaseLine

"" After text object
augroup AfterTextObject
    autocmd!
    autocmd VimEnter * call after_object#enable(['n', 'nn'], '=', ':', '+', '-', '*', '/', '#', ' ')
augroup End

"" Vimtex
let g:vimtex_view_method='zathura'

"" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<c-b>'
let g:UltiSnipsJumpBackwardTrigger='<c-z>'

"" Multiple-Cursors
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_start_word_key='g<C-n>'
let g:multi_cursor_exit_from_visual_mode=0
let g:multi_cursor_exit_from_insert_mode=0

"" Goyo + Limelight
let g:goyo_width=83

function! s:goyo_enter()
    set nolist
    set noshowmode
    set noshowcmd
    set scrolloff=999
    set sidescrolloff=0
    "Limelight
endfunction

function! s:goyo_leave()
    set list
    set noshowmode
    set showcmd
    set scrolloff=3
    set sidescrolloff=5
    "Limelight!
endfunction

augroup Goyo
    autocmd!
    autocmd User GoyoEnter nested call <SID>goyo_enter()
    autocmd User GoyoLeave nested call <SID>goyo_leave()
augroup END

"" Vimux
let g:VimuxUseNearest=1

function! VimuxSlime()
    call VimuxOpenRunner()
    call VimuxSendText(@v)
endfunction

function! SendToTmuxSplit(type, ...)
    let sel_save = &selection
    let &selection = "inclusive"
    let reg_save = @@

    if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\"vy"
    elseif a:type == 'line'
        silent exe "normal! '[V']\"vy"
    else
        silent exe "normal! `[v`]\"vy"
    endif

    call VimuxSlime()
    silent exe "normal! `v"

    let &selection = sel_save
    let @@ = reg_save
endfunction

nnoremap <silent> _ mv:set opfunc=SendToTmuxSplit<CR>g@
vnoremap <silent> _ mv:<C-U>call SendToTmuxSplit(visualmode(), 1)<CR>

"" Ale
" Using special space: U+2000 (EN QUAD)
let g:ale_set_loclist=1
let g:ale_sign_error=' ●'
let g:ale_sign_warning=' ●'
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_filetype_changed=1
let g:ale_set_highlights=1
let g:ale_set_signs=1

nmap [w <plug>(ale_previous_wrap)
nmap ]w <plug>(ale_next_wrap)
nnoremap <leader>a :ALEEnable<CR>

augroup Ale
    autocmd!
    autocmd VimEnter * ALEDisable
augroup END

"" AutoPairs
execute "set <M-p>=\<Esc>p"
execute "set <M-b>=\<Esc>b"
"let g:AutoPairsMapSpace=0

"" RustRacer
let g:racer_cmd="/usr/bin/racer"
let g:racer_experimental_completer=1

"" Deoplete
let g:deoplete#enable_at_startup=1

let g:deoplete#sources#clang#libclang_path='/usr/lib/rstudio/bin/rsclang/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/rstudio/resources/libclang'

" "" LanguageClient
" let g:LanguageClient_serverCommands = {
"             \ 'rust': ['rustup', 'run', 'nightly', 'rls'],
"             \ 'c': ['cquery'],
"             \ 'javascript': ['/opt/javascript-typescript-langserver/lib/language-server-stdio.js'],
"             \ }
"
" " Automatically start language servers.
" let g:LanguageClient_autoStart=1
"
"nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
"nnoremap <silent> <F6> :call LanguageClient_textDocument_rename()<CR>

"" Unimpaired
let g:nremap={"[": "ü", "]": "¨"}
let g:xremap={"[": "ü", "]": "¨"}
let g:oremap={"[": "ü", "]": "¨"}

"" Vim RSI
let g:rsi_no_meta=1


""""""""""""""""
"  APPEARANCE  "
""""""""""""""""

"" UI config
"syntax enable
set synmaxcol=800
set number
set showcmd
set hidden
set wildmenu  " shows autocomplete in commandline
set wildmode=longest:full,full
set completeopt=menuone,longest,preview
set lazyredraw
set mouse=a
map <ScrollWheelUp> <C-y>
map <ScrollWheelDown> <C-e>

set cursorline  " horizontal line
"set colorcolumn=81  " vertical line
set textwidth=80
set wrapmargin=0  " turns off automatic newlines
set nowrap  " line wrapping off
set showmatch  " show matching brackets
set mat=5  " bracket blinking
set list

" augroup TransparentBackground
"     autocmd!
"     autocmd ColorScheme * highlight Normal guibg=NONE ctermbg=NONE
" augroup END

augroup LighterCursorLine
    autocmd!
    "autocmd ColorScheme * highlight clear CursorLine
    "autocmd ColorScheme * highlight CursorLine guibg=#32302f
    autocmd ColorScheme * if &background == "dark" | highlight CursorLine guibg=#32302f | else | highlight CursorLine guibg=#f2e5bc | endif
augroup END

augroup BoldCursorLineNr
    autocmd!
    "autocmd ColorScheme * highlight CursorLineNR cterm=bold guibg=#282828
    autocmd ColorScheme * if &background == "dark" | highlight CursorLineNR cterm=bold guibg=#32302f | else | highlight CursorLineNR cterm=bold guibg=#f2e5bc | endif
augroup END

augroup LighterQuickFixLine
    autocmd!
    "autocmd ColorScheme * highlight QuickFixLine ctermbg=Yellow guibg=#504945
    "autocmd ColorScheme * highlight qfFileName guifg=#fe8019
    autocmd ColorScheme * if &background == "dark" | highlight QuickFixLine ctermbg=Yellow guibg=#504945 | else | highlight QuickFixLine ctermbg=Yellow guibg=#d5c4a1 | endif
    autocmd ColorScheme * if &background == "dark" | highlight qfFileName guifg=#fe8019 | else | highlight qfFileName guifg=#af3a03 | endif
augroup END

augroup SearchHighlightColor
    autocmd!
    "autocmd ColorScheme * highlight Search guibg=#282828 guifg=#fe8019
    autocmd ColorScheme * if &background == "dark" | highlight Search guibg=#282828 guifg=#fe8019 | else | highlight Search guibg=#fbf1c7 guifg=#af3a03 | endif
augroup END

""" Color VCS conflict markers
augroup VCSConflictMarker
    autocmd!
    "autocmd ColorScheme * highlight VCSConflict guibg=#cc241d guifg=#282828
    autocmd ColorScheme * if &background == "dark" | highlight VCSConflict guibg=#cc241d guifg=#282828 | else | highlight VCSConflict guibg=#cc241d guifg=#fbf1c7 | endif
    autocmd BufEnter,WinEnter * match VCSConflict '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$'
augroup END

" """ Color overlength
" augroup OverLength
"     autocmd!
"     "autocmd ColorScheme * highlight OverLength guibg=#cc241d guifg=#282828
"     autocmd ColorScheme * if &background == "dark" | highlight OverLength guibg=#cc241d guifg=#282828 | else | highlight OverLength guibg=#cc241d guifg=#fbf1c7 | endif
"     "autocmd BufEnter,WinEnter * match OverLength /\%81v./
"     "autocmd BufEnter,WinEnter * match OverLength /\%>80v.\+/
"     let collumnLimit=80
"     let pattern='\%' . (collumnLimit+1) . 'v.'
"     autocmd BufEnter,WinEnter *
"                 \ let w:m1=matchadd('OverLength', pattern, -1)
" augroup END

augroup RefreshAirline
    autocmd!
    autocmd ColorScheme * if exists(':AirlineRefresh') | :AirlineRefresh | endif
augroup END

augroup SpellBadUnderline
    autocmd!
    autocmd BufEnter,WinEnter * highlight SpellBad gui=underline term=underline cterm=underline
augroup END

if &term !=? 'linux' || has('gui_running')
    set listchars=tab:▸\ ,extends:>,precedes:<,nbsp:˷,eol:⤶,trail:~
    set fillchars=vert:│,fold:─,diff:-
    augroup TrailingSpaces
        autocmd!
        autocmd InsertEnter * set listchars-=eol:⤶,trail:~
        autocmd InsertLeave * set listchars+=eol:⤶,trail:~
    augroup END
else
    set listchars=tab:>\ ,extends:>,precedes:<,nbsp:+,eol:$,trail:~
    set fillchars=vert:\|,fold:-,diff:-
    augroup TrailingSpaces
        autocmd!
        autocmd InsertEnter * set listchars-=eol:$,trail:~
        autocmd InsertLeave * set listchars+=eol:$,trail:~
    augroup END
endif

set novisualbell  " no blinking
set noerrorbells  " no noise
set display=lastline
set laststatus=2  " always show status line
set showtabline=2  " always show tab line
set noshowmode  " Hide the default mode text (e.g. -- INSERT -- below the statusline)

"" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" function! ExpandSpaces()
"     set tabstop=2
"     set noexpandtab
"     '<,'>retab!
"     set tabstop=4
"     set expandtab
"     '<,'>retab
" endfunction
" nnoremap <leader>i :call ExpandSpaces()<CR>

"" Spaces, indents
set encoding=utf-8
set smarttab
set autoindent
"filetype plugin indent on
set linespace=0
set scrolloff=3
set sidescrolloff=5
set backspace=indent,eol,start  " backspace over everything in insert mode
set formatoptions+=roj
set nrformats-=octal
set pastetoggle=<F2>

set notimeout
set ttimeout
set ttimeoutlen=100
set updatetime=100

if filereadable('/bin/zsh')
    set shell=/bin/zsh\ --login
endif

"" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase

"" Folding
set foldenable
set foldmethod=indent
set foldnestmax=100
augroup CustomFolding
    autocmd!
    autocmd BufWinEnter * let &foldlevel=max(add(map(range(1, line('$')), 'foldlevel(v:val)'), 10))  " with this, everything is unfolded at start
augroup End

"set clipboard+=unnamed  " yanks go on clipboard instead.
set history=10000  " Number of things to remember in history.
set tabpagemax=50
set autoread
set autowrite
set ruler
set nostartofline
set nohidden
set nojoinspaces
set sessionoptions-=options

function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '┤ ' . printf("%10s", lines_count . ' lines') . ' ├'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+ ' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

"" Last position
set viminfo='10,\"100,:20,%,n~/.viminfo
augroup SavePosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
augroup END

"" Dictionary
set dictionary+=/usr/share/dict/words-insane

"" Theme and colors
set termguicolors
set background=dark
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"set t_Co=256
let g:gruvbox_bold=1
let g:gruvbox_italic=1
let g:gruvbox_underline=1
let g:gruvbox_undercurl=1

"" Use environment variable
if !empty($VIM_COLOR)
    silent! colorscheme $VIM_COLOR
else
    silent! colorscheme gruvbox
endif

"" GUI options
set guifont=Iosevka\ Custom
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar

"" Switch cursor according to mode
if &term !=? 'linux' || has('gui_running')
    let &t_SI="\<Esc>[6 q"
    let &t_SR="\<Esc>[4 q"
    let &t_EI="\<Esc>[2 q"

    " let &t_ue="\<Esc>[4:0m"
    " let &t_us="\<Esc>[4:1m"
    " let &t_Ce="\<Esc>[4:0m"
    " let &t_Cs="\<Esc>[4:3m"
endif

""" TODO Disable highlighting on re-source (bug)
nohlsearch


""""""""""""""
"  FILETYPE  "
""""""""""""""

augroup QFAdjustWindowHeight
    autocmd FileType qf call AdjustWindowHeight(3, 10)
augroup END

function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    exe max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction


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


"""""""""""""""""""
"  VIMRC FOLDING  "
"""""""""""""""""""

"" Autofolding .vimrc
" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/

""" Defines a foldlevel for each line of code
function! VimFolds(lnum)
    let s:thisline = getline(a:lnum)
    if match(s:thisline, '^"" ') >= 0
        return '>2'
    endif
    if match(s:thisline, '^""" ') >= 0
        return '>3'
    endif
    let s:two_following_lines = 0
    if line(a:lnum) + 2 <= line('$')
        let s:line_1_after = getline(a:lnum+1)
        let s:line_2_after = getline(a:lnum+2)
        let s:two_following_lines = 1
    endif
    if !s:two_following_lines
        return '='
    else
        if (match(s:thisline, '^"""""') >= 0) &&
                    \ (match(s:line_1_after, '^"  ') >= 0) &&
                    \ (match(s:line_2_after, '^""""') >= 0)
            return '>1'
        else
            return '='
        endif
    endif
endfunction

""" Defines a foldtext
function! VimFoldText()
    " handle special case of normal comment first
    let s:info = '('.string(v:foldend-v:foldstart).' l)'
    if v:foldlevel == 1
        let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
    elseif v:foldlevel == 2
        let s:line = '   ●  '.getline(v:foldstart)[3:]
    elseif v:foldlevel == 3
        let s:line = '       ▪ '.getline(v:foldstart)[4:]
    endif
    if strwidth(s:line) > 80 - len(s:info) - 3
        return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
    else
        return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
    endif
endfunction

""" Set foldsettings automatically for vim files
augroup VimFolding
    autocmd!
    autocmd FileType vim
                \ setlocal foldmethod=expr |
                \ setlocal foldexpr=VimFolds(v:lnum) |
                \ setlocal foldtext=VimFoldText() |
                " \ set foldcolumn=2 foldminlines=2
augroup END


"""""""""""
"  LINKS  "
"""""""""""

"" Links to check out

" checkout: https://github.com/zenbro/dotfiles/blob/master/.nvimrc
"           https://github.com/spf13/spf13-vim/blob/3.0/.vimrc
"           https://github.com/euclio/vimrc/blob/master/vimrc
"           https://github.com/KevOBrien/dotfiles
"           https://bitbucket.org/sjl/dotfiles/src/28205343c464b44fd36970d2588a74183ff73299/vim/vimrc
