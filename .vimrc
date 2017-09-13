" vimrc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" path settings
set rtp+=/usr/local/opt/fzf


" plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-vinegar'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/vim-easy-align'
Plug 'tomtom/tcomment_vim'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'jiangmiao/auto-pairs'
Plug 'mbbill/undotree'
Plug 'wellle/targets.vim'
Plug 'christoomey/vim-titlecase'

" language specific
Plug 'plasticboy/vim-markdown'

" themes
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'chriskempson/base16-vim'
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim/' }

call plug#end()


" plugin settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" fzf
if executable('fzf')
  autocmd VimEnter * nnoremap <Leader>f :FZF<CR>
endif

" the silver searcher
if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore-case\ --column\ --vimgrep
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  " integrate ag into ack
  let g:ackprg='ag --nogroup --nocolor --ignore-case --column --vimgrep --hidden'

  " use ag in ctrlp for listing files. lightning fast and respects .gitignore
  let g:ctrlp_user_command='ag %s -l --nocolor -g "" --hidden'

  " ag is fast enough that ctrlp doesn't need to cache
  let g:ctrlp_use_caching=0

  " ag
   autocmd VimEnter * nnoremap <Leader>a :Ag<CR>
endif


" leader key
let mapleader=' '


" easier split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" german key mappings
map ü <C-]>
" map <C-k> {
map ä {
" map <C-j> }
map ö }
" map ' /

imap <C-B> <Esc>O

" magic search
map ,/ /\v
map ,? ?\v
cmap ,s %s/\v
cmap ,g %g/\v

" norm
vnoremap <C-n> :norm<Space>

" more natural splits
" set splitbelow
" set splitright

" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

"   augroup quickfix
"     autocmd!
"     autocmd QuickFixCmdPost [^l]* cwindow
"     autocmd QuickFixCmdPost l*    lwindow
"   augroup END




" theme
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if &term !=? 'linux' || has("gui_running")
  set guifont=Meslo\ LG\ S\ for\ Powerline
  set t_Co=256
  set termguicolors
  set background=dark
  " let g:gruvbox_contrast_dark='hard'
  let g:gruvbox_italic=1
  colorscheme gruvbox
endif

" spaces, indents and tabs
set encoding=utf-8
set shiftwidth=2
set softtabstop=2
set tabstop=2
set softtabstop=2
set tabstop=2
set expandtab
set textwidth=0
set linespace=0
set scrolloff=3

" special rules for some filetypes
autocmd BufRead,BufNewFile *.xml set noexpandtab

" ui config
set number
" set relativenumber
set showcmd
set hidden
set wildmenu  " shows autocomplete in commandline
set wildmode=longest:full,full
set textwidth=80
" set colorcolumn=81  " vertical line
set cursorline  " horizontal line
set wrapmargin=0  " turns off automatic newlines
set nowrap  " line wrapping off
syntax enable

set showmatch  " show matching brackets
set mat=5  " bracket blinking

set list
set lcs=tab:\▸\ ,eol:\↵,trail:\~,extends:>,precedes:<
set viminfo^=!

set novisualbell  " no blinking
set noerrorbells  " no noise
set laststatus=2  " always show status line
set showtabline=2  " always show tab line
set noshowmode  " Hide the default mode text (e.g. -- INSERT -- below the statusline)

" searching
set incsearch
set hlsearch
set ignorecase
set smartcase

" folding
set foldenable
set foldmethod=indent
autocmd BufWinEnter * let &foldlevel=max(add(map(range(1, line('$')), 'foldlevel(v:val)'), 10))  " with this, everything is unfolded at start
set foldnestmax=100
set cf  " enable error files & error jumping.
" set clipboard+=unnamed  " yanks go on clipboard instead.
set history=10000 " Number of things to remember in history.
set autowrite  " writes on make/shell commands
set ruler  " ruler on
set timeoutlen=2000  " time to wait after esc (default causes an annoying delay)

if has('persistent_undo')
  set undodir=~/.vim/tmp/undo/
  set undofile
endif

" formatting (some of these are for coding in c and c++)
set bs=2  " backspace over everything in insert mode
set nocp incsearch
set cinoptions=:0,p0,t0
" set cinwords=if,else,while,do,for,switch,case
set formatoptions=tcqr
set cindent
set smarttab
set pastetoggle=<F10>

" remove trailing whitespaces with F5
nnoremap <F5> :call <SID>StripTrailingWhitespaces() <CR>

if !exists('g:airline_symbols')
  let g:airline_symbols={}
endif

" unicode symbols
let g:airline_left_sep='»'
let g:airline_left_sep='▶'
let g:airline_right_sep='«'
let g:airline_right_sep='◀'
let g:airline_symbols.crypt='🔒'
let g:airline_symbols.linenr='☰'
let g:airline_symbols.linenr='␊'
let g:airline_symbols.linenr='␤'
let g:airline_symbols.linenr='¶'
let g:airline_symbols.maxlinenr=''
let g:airline_symbols.maxlinenr='㏑'
let g:airline_symbols.branch='⎇'
let g:airline_symbols.paste='ρ'
let g:airline_symbols.paste='Þ'
let g:airline_symbols.paste='∥'
let g:airline_symbols.spell='Ꞩ'
let g:airline_symbols.notexists='∄'
let g:airline_symbols.whitespace='Ξ'

" powerline symbols
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.branch=''
let g:airline_symbols.readonly=''
let g:airline_symbols.linenr='☰'
let g:airline_symbols.maxlinenr=''

" air-line
" let g:airline_theme='molokai'
" let g:airline_theme='solarized'
" let g:airline_solarized_bg='dark'
" let g:airline_theme='onedark'
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#mixed_indent_algo=1
let g:airline_powerline_fonts=1
" let g:airline_skip_empty_sections=1

" " default curser color while searching
" nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
" nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
" nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>
" nnoremap * :let @/=""<CR>:call gruvbox#hls_show()<CR>*
" nnoremap / :let @/=""<CR>:call gruvbox#hls_show()<CR>/
" nnoremap ? :let @/=""<CR>:call gruvbox#hls_show()<CR>?

" color overlength
highlight OverLength ctermbg=darkred ctermfg=white guibg=#592929
" match OverLength /\%>80v.\+/
match OverLength /\%81v./

" easymotion
let g:EasyMotion_do_mapping=0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase=1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" :h g:incsearch#auto_nohlsearch
set hlsearch
let g:incsearch#auto_nohlsearch=1
map n <Plug>(incsearch-nohl-n)
map N <Plug>(incsearch-nohl-N)
map * <Plug>(incsearch-nohl-*)
map # <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)

" remove trailing whitespaces
nnoremap <silent> <F5> :let _s=@/ <Bar> :%s/\s\+$//e <Bar> :let @/=_s <Bar> :nohl <Bar> :unlet _s <CR>

" " NERDTree
" let NERDTreeHijackNetrw=1
" let NERDTreeQuitOnOpen=1
" let NERDTreeMinimalUI=1
" let NERDTreeDirArrows=1
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" map <C-M> :NERDTreeToggle<CR>

" " NERDTress File highlighting
" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
" endfunction

" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" unimpaired
nmap <S-H> [
nmap <S-L> ]
omap <S-H> [
omap <S-L> ]
xmap <S-H> [
xmap <S-L> ]

" easy align
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" undotree
nnoremap <F4> :UndotreeToggle<CR>

" titlecase
let g:titlecase_map_keys=0
nmap gct <Plug>Titlecase
vmap gct <Plug>Titlecase
nmap gcT <Plug>TitlecaseLine

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" [[b]commits] customize the options used by 'git log':
let g:fzf_commits_log_options='--graph --color=always --format="%c(auto)%h%d %s %c(black)%c(bold)%cr"'


" links
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" checkout: https://github.com/zenbro/dotfiles/blob/master/.nvimrc
"           https://github.com/spf13/spf13-vim/blob/3.0/.vimrc
"           https://github.com/euclio/vimrc/blob/master/vimrc

