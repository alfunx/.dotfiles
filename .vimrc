"""""""""""
"  VIMRC  "
"""""""""""

"" Path settings

set rtp+=/usr/local/opt/fzf


"""""""""""""
"  PLUGINS  "
"""""""""""""

if filereadable($HOME . '/.vim/autoload/plug.vim') == 0
  :silent !mkdir -p ~/.vim/autoload > /dev/null 2>&1
  :silent !mkdir -p ~/.vim/plugged > /dev/null 2>&1
  :silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        \ > /dev/null 2>&1
endif

call plug#begin('~/.vim/plugged')

" General
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-rsi'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'haya14busa/incsearch-easymotion.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'christoomey/vim-titlecase'
Plug 'tomtom/tcomment_vim'
Plug 'ap/vim-css-color'
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" Text objects
Plug 'wellle/targets.vim'
Plug 'junegunn/vim-after-object'
Plug 'michaeljsmith/vim-indent-object'

" Snippets
" Plug 'Valloric/YouCompleteMe'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Language specific
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'

" Themes
Plug 'morhetz/gruvbox'

" Don't load in console
if &term !=? 'linux' || has("gui_running")
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
endif

call plug#end()

runtime ftplugin/man.vim


""""""""""""""""""
"  KEY MAPPINGS  "
""""""""""""""""""

"" Leader key
nnoremap <Space> <Nop>
nnoremap ü <Nop>
let mapleader=" "
let maplocalleader="ü"

"" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"   augroup quickfix
"     autocmd!
"     autocmd QuickFixCmdPost [^l]* cwindow
"     autocmd QuickFixCmdPost l*    lwindow
"   augroup END

"" German keyboard mappings
" noremap ü <C-]>
noremap ä {
noremap ö }

" Use CTRL-S for saving, also in Insert mode
noremap <silent> <C-S> :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

"" insert mode mappings
inoremap OO <C-O>O
inoremap PP <C-O>o

" select last inserted text
nnoremap gV `[v`]

"" Magic regex search
noremap ,/ /\v
noremap ,? ?\v
cnoremap ,s %s/\v
cnoremap ,g %g/\v

" remove trailing whitespaces
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>


"""""""""""""""""""""
"  PLUGIN SETTINGS  "
"""""""""""""""""""""

"" FZF
if executable('fzf')
  autocmd VimEnter * nnoremap <Leader>f :FZF<CR>
endif

" default key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" default fzf layout
let g:fzf_layout = { 'down': '~30%' }

" customize the options used by 'git log'
let g:fzf_commits_log_options='--graph --color=always --format="%c(auto)%h%d %s %c(black)%c(bold)%cr"'

" command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)
" imap <leader><tab> <plug>(fzf-maps-i)

nnoremap <leader>b :Buffers<CR>
vnoremap <leader>b <C-C>:Buffers<CR>

" insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" use custom dictionary
inoremap <expr> <c-x><c-k> fzf#complete('cat /usr/share/dict/words-insane')

"" RG
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --line-number --no-heading --ignore-case --follow --color=always --colors="match:none" --colors="path:fg:white" --colors="line:fg:white" '.shellescape(<q-args>), 0,
      \ <bang>0)

if executable('rg')
  autocmd VimEnter * nnoremap <Leader>r :Rg<CR>
  set grepprg=rg\ --vimgrep
  set grepformat^=%f:%l:%c:%m
endif

"" AG
command! -bang -nargs=* Ag
      \ call fzf#vim#ag(
      \ <q-args>, '--color-path "0;37" --color-line-number "0;37" --color-match "" --follow',
      \ <bang>0)

if executable('ag')
  autocmd VimEnter * nnoremap <Leader>a :Ag<CR>
endif

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

""" Powerline symbols
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.branch=''
let g:airline_symbols.readonly=''
let g:airline_symbols.linenr='☰'
let g:airline_symbols.maxlinenr=''

""" Airline settings
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#mixed_indent_algo=1
let g:airline_powerline_fonts=1

"" EasyMotion
" let g:EasyMotion_do_mapping=0  " Disable default mappings
let g:EasyMotion_smartcase=1  " Turn on case insensitive feature
let g:EasyMotion_keys='asdghklqwertyuiopzxcvbnmfj,'

" nmap s <Plug>(easymotion-overwin-f)
nmap s <Plug>(easymotion-overwin-f2)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

"" Incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

let g:incsearch#auto_nohlsearch=1
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

"" Incsearch-EasyMotion
map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

"" Netrw
let g:netrw_liststyle=0
let g:netrw_preview=1

"" Unimpaired
nmap <S-H> [
nmap <S-L> ]
omap <S-H> [
omap <S-L> ]
xmap <S-H> [
xmap <S-L> ]

"" Vim RSI
let g:rsi_no_meta=1

"" EasyAlign
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"" Undotree
nnoremap <F4> :UndotreeToggle<CR>

"" Titlecase
let g:titlecase_map_keys=0
nmap gwt <Plug>Titlecase
vmap gwt <Plug>Titlecase
nmap gwT <Plug>TitlecaseLine

"" After text object
autocmd VimEnter * call after_object#enable(['m', 'mm'], '=', ':', '+', '-', '*', '/', '#', ' ')

"" Vimtex
let g:vimtex_view_method='zathura'

"" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"" Goyo + Limelight
function! s:goyo_enter()
  set nolist
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
endfunction

function! s:goyo_leave()
  set list
  highlight OverLength ctermbg=darkred ctermfg=white guibg=#9d0006 guifg=#fbf1c7
  match OverLength /\%81v./
  set noshowmode
  set showcmd
  set scrolloff=3
  Limelight!
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

"" tslime
let g:tslime_always_current_session=1
let g:tslime_always_current_window=1

vmap <C-c><C-c> <Plug>SendSelectionToTmux

"" Vimux
let g:VimuxUseNearest=1

function! VimuxSlime()
  call VimuxOpenRunner()
  call VimuxSendText(@v)
  " call VimuxSendKeys("Enter")
endfunction

vmap <Leader>vs "vy :call VimuxSlime()<CR>


""""""""""""""""
"  APPEARANCE  "
""""""""""""""""

"" Theme and colors
set guifont=Meslo\ LG\ S\ for\ Powerline
set termguicolors
set background=dark
let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
set t_Co=256
let g:gruvbox_italic=1
colorscheme gruvbox

"" UI config
syntax enable
set nocompatible
set number
set showcmd
set hidden
set wildmenu  " shows autocomplete in commandline
set wildmode=longest:full,full
set lazyredraw
set mouse=a

set cursorline  " horizontal line
set textwidth=80
" set colorcolumn=81  " vertical line
set wrapmargin=0  " turns off automatic newlines
set nowrap  " line wrapping off
set showmatch  " show matching brackets
set mat=5  " bracket blinking
set list

if &term !=? 'linux' || has("gui_running")
  set listchars=tab:▸\ ,eol:↵,trail:~,extends:>,precedes:<
  set fillchars=vert:│,fold:─,diff:-
else
  set listchars=tab:~\ ,eol:$,trail:~,extends:>,precedes:<
  set fillchars=vert:\|,fold:-,diff:-
endif

set novisualbell  " no blinking
set noerrorbells  " no noise
set display=lastline
set laststatus=2  " always show status line
set showtabline=2  " always show tab line
set noshowmode  " Hide the default mode text (e.g. -- INSERT -- below the statusline)

"" Spaces, indents and tabs
set encoding=utf-8
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab
set smarttab
set autoindent
set cindent
set linespace=0
set scrolloff=3
set backspace=2  " backspace over everything in insert mode
set cinoptions=:0,p0,t0
" set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set pastetoggle=<F10>

""" Color overlength
highlight OverLength ctermbg=darkred ctermfg=white guibg=#9d0006 guifg=#fbf1c7
match OverLength /\%81v./
" match OverLength /\%>80v.\+/

"" Searching
set incsearch
set hlsearch
set ignorecase
set smartcase

"" Folding
set foldenable
set foldmethod=indent
autocmd BufWinEnter * let &foldlevel=max(add(map(range(1, line('$')), 'foldlevel(v:val)'), 10))  " with this, everything is unfolded at start
set foldnestmax=100

set cf  " enable error files & error jumping.
" set clipboard+=unnamed  " yanks go on clipboard instead.
set history=10000  " Number of things to remember in history.
set autoread
set autowrite
set ruler
set nostartofline
set timeoutlen=2000  " time to wait after esc (default causes an annoying delay)

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
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

"" Dictionary
set dictionary+=/usr/share/dict/words-insane


""""""""""""""""""""""""""
"  BACKUP / SWAP / UNDO  "
""""""""""""""""""""""""""

if isdirectory($HOME . '/.vim/backup') == 0
  :silent !mkdir -p ~/.vim/backup >/dev/null 2>&1
endif
set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/
set backupdir^=./.vim-backup/
set backup

if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

if exists("+undofile")
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  set undodir=./.vim-undo//
  set undodir+=~/.vim/undo//
  set undofile
endif


"""""""""""""""""""""""
"  LANGUAGE SPECIFIC  "
"""""""""""""""""""""""

augroup configgroup
  autocmd!
  autocmd Filetype python setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
  autocmd Filetype java setlocal noexpandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd Filetype lua setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
augroup END


"""""""""""""""""""
"  VIMRC FOLDING  "
"""""""""""""""""""

"" Autofolding .vimrc
" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/

""" defines a foldlevel for each line of code
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
    endif
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

""" defines a foldtext
function! VimFoldText()
  " handle special case of normal comment first
  let s:info = '('.string(v:foldend-v:foldstart).' l)'
  if v:foldlevel == 1
    let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
  elseif v:foldlevel == 2
    let s:line = '   ●  '.getline(v:foldstart)[3:]
  elseif v:foldlevel == 3
    let s:line = '     ▪ '.getline(v:foldstart)[4:]
  endif
  if strwidth(s:line) > 80 - len(s:info) - 3
    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
  else
    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
  endif
endfunction

""" set foldsettings automatically for vim files
augroup fold_vimrc
  autocmd!
  autocmd FileType vim
                   \ setlocal foldmethod=expr |
                   \ setlocal foldexpr=VimFolds(v:lnum) |
                   \ setlocal foldtext=VimFoldText() |
     "              \ set foldcolumn=2 foldminlines=2
augroup END


"""""""""""
"  LINKS  "
"""""""""""

"" Links to check out

" checkout: https://github.com/zenbro/dotfiles/blob/master/.nvimrc
"           https://github.com/spf13/spf13-vim/blob/3.0/.vimrc
"           https://github.com/euclio/vimrc/blob/master/vimrc
"           https://github.com/KevOBrien/dotfiles
