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
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-sleuth'
"Plug 'tpope/vim-endwise'
Plug 'tpope/vim-abolish'
"Plug 'tpope/vim-commentary'
Plug 'tomtom/tcomment_vim'
Plug 'whiteinge/diffconflicts'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'haya14busa/incsearch.vim'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-grepper'
Plug 'terryma/vim-multiple-cursors'
"Plug 'terryma/vim-expand-region'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'ap/vim-css-color'
Plug 'xtal8/traces.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'w0rp/ale'
Plug 'majutsushi/tagbar'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'editorconfig/editorconfig-vim'

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
"Plug 'ncm2/ncm2-ultisnips'

" Language server
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh',
            \ }

" Completion
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-bufword'
"Plug 'Shougo/echodoc.vim'

" Language specific
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'lervag/vimtex', { 'for': ['latex', 'tex'] }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'zchee/deoplete-clang', { 'for': ['c', 'cpp'] }
Plug 'Shougo/neco-vim', { 'for': 'vim' }

" Syntax
Plug 'cespare/vim-toml'

" Themes
Plug 'alfunx/gruvbox'  " fork of 'morhetz/gruvbox'

" Custom - syntax checkers
Plug 'vim-syntastic/syntastic'
Plug 'nvie/vim-flake8'

" Custom - regular session saving
Plug 'tpope/vim-obsession'

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
"nnoremap <silent> <C-h> <C-w><C-h>
"nnoremap <silent> <C-j> <C-w><C-j>
"nnoremap <silent> <C-k> <C-w><C-k>
"nnoremap <silent> <C-l> <C-w><C-l>

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

"nnoremap <silent> <Home> <C-w><
"nnoremap <silent> <PageDown> <C-w>-
"nnoremap <silent> <PageUp> <C-w>+
"nnoremap <silent> <End> <C-w>>

"" New tab
nnoremap <silent> <C-w>t :tabnew<CR>
nnoremap <silent> <C-w><C-t> :tabnew<CR>

"" Tab navigation
nnoremap <silent> <C-w><C-h> gT
nnoremap <silent> <C-w><C-l> gt

"" Fullscreen
nnoremap <silent> <C-w>F <C-w>_<C-w><Bar>

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
nnoremap <silent> <C-s> :write<CR>
xnoremap <silent> <C-s> <Esc>:write<CR>
inoremap <silent> <C-s> <C-o>:write<CR><Esc>

"" Quickfix & Loclist
nnoremap <silent> <leader>q :copen<CR>
nnoremap <silent> <leader>l :lopen<CR>

"" Entire text-object
xnoremap <silent> ie :<C-u>normal! G$Vgg0<CR>
onoremap <silent> ie :<C-u>normal! G$Vgg0<CR>

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
nnoremap <silent> <M-1> 1gt
nnoremap <silent> <M-2> 2gt
nnoremap <silent> <M-3> 3gt
nnoremap <silent> <M-4> 4gt
nnoremap <silent> <M-5> 5gt
nnoremap <silent> <M-6> 6gt
nnoremap <silent> <M-7> 7gt
nnoremap <silent> <M-8> 8gt
nnoremap <silent> <M-9> :tablast<CR>

" Wildmenu
set wildchar=<Tab>
set wildcharm=<Tab>
cnoremap <expr> <Tab> getcmdtype() =~ '[?/]' ? '<C-g>' : '<Tab>'
cnoremap <expr> <S-Tab> getcmdtype() =~ '[?/]' ? '<C-t>' : feedkeys('<S-Tab>', 'int')[1]

" Remove trailing whitespaces
nnoremap <silent> <F3> mz:keepp %s/\\\@1<!\s\+$//e<CR>`z

" Allow saving of files as sudo
command! W execute 'silent! w !sudo /usr/bin/tee % >/dev/null' <Bar> edit!

" Set path to current file
command! -bang -nargs=* Cd  cd %:p:h

" No highlight
execute "set <M-b>=\<Esc>b"
nnoremap <silent> <M-b> :<C-u>nohlsearch<CR>

" augroup incsearch_highlight
"     autocmd!
"     autocmd CmdlineEnter [/\?] :set hlsearch
"     autocmd CmdlineLeave [/\?] :set nohlsearch
" augroup END

" Run last macro
nnoremap Q @@

" Run macro on visual selection
function! ExecuteMacroOverVisualRange()
    echo "@".getcmdline()
    execute ":'<,'>normal @".nr2char(getchar())
endfunction
xnoremap <silent> @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Change register
function! ChangeReg() abort
    let x = nr2char(getchar())
    call feedkeys("q:ilet @" . x . " = \<C-r>\<C-r>=string(@" . x . ")\<CR>\<Esc>$", 'n')
endfunction
nnoremap <silent> cx :call ChangeReg()<CR>

" Diff update
nnoremap <silent> du :diffupdate<CR>

" Scroll
map <silent> <ScrollWheelUp> <C-y>
map <silent> <ScrollWheelDown> <C-e>


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

" FZF
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>w :Windows<CR>
nnoremap <leader>t :Tags<CR>

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

" if executable('rg')
"     augroup Rg
"         autocmd!
"         autocmd VimEnter * nnoremap <Leader>r :Rg<CR>
"     augroup End
" elseif executable('ag')
"     augroup Ag
"         autocmd!
"         autocmd VimEnter * nnoremap <Leader>r :Ag<CR>
"     augroup End
" endif

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
            \ 'grepprg':    'rg --vimgrep',
            \ 'grepformat': '%f:%l:%c:%m',
            \ 'escape':     '\^$.*+?()[]{}|'
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
let g:gitgutter_map_keys=0
nmap <leader>hp <Plug>GitGutterPrevHunk
nmap <leader>ha <Plug>GitGutterStageHunk
nmap <leader>hu <Plug>GitGutterUndoHunk
nmap ]c <Plug>GitGutterNextHunk
nmap [c <Plug>GitGutterPrevHunk

let g:gitgutter_sign_added='┃'
let g:gitgutter_sign_modified='┃'
let g:gitgutter_sign_removed='◢'
let g:gitgutter_sign_removed_first_line='◥'
let g:gitgutter_sign_modified_removed='◢'

"" Sneak
let g:sneak#label=1
let g:sneak#use_ic_scs=1
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

"" Incsearch
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"let g:incsearch#magic='\v'
let g:incsearch#smart_backward_word=1
let g:incsearch#consistent_n_direction=1
let g:incsearch#auto_nohlsearch=0
let g:incsearch#no_inc_hlsearch=1
let g:incsearch#separate_highlight=1
let g:incsearch#no_inc_hlsearch=1

"" TComment
let g:tcomment_mapleader1='<c-,>'
nnoremap <leader>c V:TCommentInline<CR>
xnoremap <leader>c :TCommentInline<CR>

"" Netrw
let g:netrw_liststyle=0
let g:netrw_preview=1

"" EasyAlign
xmap <CR> <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"" Undotree
nnoremap <silent> <F4> :UndotreeToggle<CR>

"" Tagbar
nnoremap <silent> <F5> :TagbarToggle<CR>

"" After text object
augroup AfterTextObject
    autocmd!
    autocmd VimEnter * call after_object#enable(['n', 'nn'], '=', ':', '+', '-', '*', '/', '#', ' ')
augroup End

"" Vimtex
let g:vimtex_view_method='zathura'

"" UltiSnips
let g:UltiSnipsExpandTrigger='<Tab>'
let g:UltiSnipsJumpForwardTrigger='<C-k>'
let g:UltiSnipsJumpBackwardTrigger='<C-j>'
let g:UltiSnipsEditSplit="vertical"

"" Multiple-Cursors
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_key='<C-n>'
let g:multi_cursor_select_all_key='<A-n>'
let g:multi_cursor_start_word_key='g<C-n>'
let g:multi_cursor_select_all_word_key='g<A-n>'
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'
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
xnoremap <silent> _ mv:<C-U>call SendToTmuxSplit(visualmode(), 1)<CR>

"" ALE
" Use special space: ( ) U+2000 (EN QUAD)
let g:ale_set_loclist=1
let g:ale_sign_error='●'
let g:ale_sign_warning='●'
let g:ale_sign_info='●'
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_enter=1
let g:ale_lint_on_save=1
let g:ale_lint_on_filetype_changed=1
let g:ale_set_highlights=1
let g:ale_set_signs=1

let g:ale_completion_enabled=1

nmap [w <plug>(ale_previous_wrap)
nmap ]w <plug>(ale_next_wrap)
nnoremap <silent> <leader>a :ALEToggle <Bar> echo g:ale_enabled ? 'ALE enabled' : 'ALE disabled' <CR>

augroup ALE
    autocmd!
    autocmd VimEnter * ALEDisable
augroup END

"" AutoPairs
execute "set <M-p>=\<Esc>p"
execute "set <M-e>=\<Esc>e"
execute "set <M-z>=\<Esc>z"
let g:AutoPairsShortcutBackInsert='<M-z>'
let g:AutoPairsMultilineClose=0
let g:AutoPairs={'(':')', '[':']', '{':'}', "'":"'", '"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''"}

"" RustRacer
let g:racer_cmd="/usr/bin/racer"
let g:racer_experimental_completer=0

"" NCM2
let g:ncm2#complete_delay=60
let g:ncm2#popup_delay=300
let g:ncm2#auto_popup=1

imap <C-n> <plug>(ncm2_manual_trigger)
imap <silent><expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
imap <silent><expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"

augroup NCM2
    autocmd!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    autocmd User Ncm2PopupOpen set completeopt=menuone,noinsert,noselect
    autocmd User Ncm2PopupClose set completeopt=menuone
    autocmd TextChangedI * call ncm2#auto_trigger()
augroup END

"" EchoDoc
let g:echodoc#enable_at_startup=1

"" LanguageClient
let g:LanguageClient_autoStart=1
let g:LanguageClient_diagnosticsList="Location"
let g:LanguageClient_hoverPreview="Never"

let g:LanguageClient_serverCommands = {
            \ 'rust':   ['rustup', 'run', 'stable', 'rls'],
            \ 'java':   ['jdtls'],
            \ 'c':      ['ccls'],
            \ 'cpp':    ['ccls'],
            \ 'python': ['pyls'],
            \ }

let g:LanguageClient_diagnosticsDisplay = {
            \     1: {
            \         "name": "Error",
            \         "texthl": "ALEError",
            \         "signText": "●",
            \         "signTexthl": "ALEErrorSign",
            \     },
            \     2: {
            \         "name": "Warning",
            \         "texthl": "ALEWarning",
            \         "signText": "●",
            \         "signTexthl": "ALEWarningSign",
            \     },
            \     3: {
            \         "name": "Information",
            \         "texthl": "ALEInfo",
            \         "signText": "●",
            \         "signTexthl": "ALEInfoSign",
            \     },
            \     4: {
            \         "name": "Hint",
            \         "texthl": "ALEInfo",
            \         "signText": "●",
            \         "signTexthl": "ALEInfoSign",
            \     },
            \ }

function! LanguageClient_settings()
    if !has_key(g:LanguageClient_serverCommands, &filetype)
        return
    endif

    " setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

    nnoremap <buffer><silent> K :call LanguageClient_contextMenu()<CR>
    nnoremap <buffer><silent> <F1> :call LanguageClient_textDocument_hover()<CR>
    nnoremap <buffer><silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
    nnoremap <buffer><silent> <leader>x :call LanguageClient_textDocument_typeDefinition()<CR>
    nnoremap <buffer><silent> <leader>y :call LanguageClient_textDocument_documentSymbol()<CR>
    nnoremap <buffer><silent> <leader>r :call LanguageClient_textDocument_references()<CR>

    nnoremap <buffer><silent> <leader>gr :call LanguageClient_textDocument_rename()<CR>
    nnoremap <buffer><silent> <leader>gc :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.camelcase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>gs :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.snakecase(expand('<cword>'))})<CR>
    nnoremap <buffer><silent> <leader>gu :call LanguageClient#textDocument_rename(
                \ {'newName': Abolish.uppercase(expand('<cword>'))})<CR>
endfunction

augroup LanguageClient_config
    autocmd!
    autocmd User LanguageClientStarted set signcolumn=yes
    autocmd User LanguageClientStopped set signcolumn=auto
augroup END

augroup LanguageClient_settings
    autocmd!
    autocmd FileType * call LanguageClient_settings()
augroup END

function! ExpandLspSnippet()
    call UltiSnips#ExpandSnippetOrJump()
    if !pumvisible() || empty(v:completed_item)
        return ''
    endif

    " Only expand Lsp if UltiSnips#ExpandSnippetOrJump not effect
    let l:value = v:completed_item['word']
    let l:matched = len(l:value)
    if l:matched <= 0
        return ''
    endif

    " Remove inserted chars before expand snippet
    if col('.') == col('$')
        let l:matched -= 1
        exec 'normal! ' . l:matched . 'Xx'
    else
        exec 'normal! ' . l:matched . 'X'
    endif

    if col('.') == col('$') - 1
        " Move to $ if at the end of line
        call cursor(line('.'), col('$'))
    endif

    " Expand snippet
    call UltiSnips#Anon(l:value)
    return ''
endfunction

inoremap <silent> <C-k> <C-r>=ExpandLspSnippet()<CR>

"" Unimpaired
let g:nremap={"[": "ü", "]": "¨"}
let g:xremap={"[": "ü", "]": "¨"}
let g:oremap={"[": "ü", "]": "¨"}

"" Vim RSI
let g:rsi_no_meta=1


""""""""""""""
"  SETTINGS  "
""""""""""""""

set synmaxcol=800
set number
set showcmd
set hidden
set wildmenu
set wildmode=longest:full,full
set completeopt=menuone,noinsert,noselect
set shortmess+=atIc
set lazyredraw
set mouse=a
set diffopt+=hiddenoff,algorithm:histogram

set cursorline
set textwidth=80
set wrapmargin=0
set nowrap
set showmatch
set matchtime=5
set list

set novisualbell
set noerrorbells
set display=lastline
set laststatus=2
set showtabline=2
set noshowmode

set notimeout
set ttimeout
set ttimeoutlen=100
set updatetime=100

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

set encoding=utf-8
set smarttab
set autoindent
set linespace=0
set scrolloff=3
set sidescrolloff=5
set backspace=indent,eol,start
set formatoptions+=roj
set nrformats-=octal
set pastetoggle=<F2>
set dictionary+=/usr/share/dict/words-insane

"set clipboard+=unnamed,unnamedplus
set history=10000
set tabpagemax=50
set autoread
set autowrite
set ruler
set nostartofline
set nohidden
set nojoinspaces
set sessionoptions-=options

if filereadable('/bin/zsh')
    set shell=/bin/zsh\ --login
endif

set incsearch
set hlsearch
set ignorecase
set smartcase

set foldenable
set foldmethod=indent
set foldnestmax=100

set guifont=monospace
set guioptions-=mTrl


"""""""""""""
"  AUTOCMD  "
"""""""""""""

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

" augroup SearchHighlightColor
"     autocmd!
"     "autocmd ColorScheme * highlight Search guibg=#282828 guifg=#fe8019
"     autocmd ColorScheme * if &background == "dark" | highlight Search guibg=#282828 guifg=#fe8019 | else | highlight Search guibg=#fbf1c7 guifg=#af3a03 | endif
" augroup END

augroup VCSConflictMarker
    autocmd!
    "autocmd ColorScheme * highlight VCSConflict guibg=#cc241d guifg=#282828
    autocmd ColorScheme * if &background == "dark" | highlight VCSConflict guibg=#cc241d guifg=#282828 | else | highlight VCSConflict guibg=#cc241d guifg=#fbf1c7 | endif
    autocmd BufEnter,WinEnter * match VCSConflict '^\(<\|=\||\|>\)\{7\}\([^=].\+\)\?$'
augroup END

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

augroup AutoRead
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI ?* if getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
augroup END

if &term !=? 'linux' || has('gui_running')
    set listchars=tab:›\ ,extends:>,precedes:<,nbsp:˷,eol:⤶,trail:~
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

augroup CustomFolding
    autocmd!
    autocmd BufWinEnter * let &foldlevel=max(add(map(range(1, line('$')), 'foldlevel(v:val)'), 10))  " with this, everything is unfolded at start
augroup End

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

set viminfo='10,\"100,:20,%,n~/.viminfo
augroup SavePosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute 'normal! g`"zvzz' | endif
augroup END


"""""""""""
"  THEME  "
"""""""""""

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


""""""""""""
"  BUGFIX  "
""""""""""""

nohlsearch


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
