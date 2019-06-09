" Setup -------------------------------------------------------------------- {{{

if v:version < 800
  echoerr 'This vimrc requires Vim 8.0 or later.'
  quit
endif

if has('multi_byte')
  set encoding=utf-8
  scriptencoding utf-8
endif

" Paths
call vimrc#paths#setup()

" Python
call vimrc#python#setup()

" Plugins
call vimrc#plugins#setup()

" }}}

" General settings --------------------------------------------------------- {{{

" Do case insensitive matching
set ignorecase
" Turns off ignorecase when pattern contains upper case chars
set smartcase
" incremental search
set incsearch
" support this types of files in this order
set fileformats=unix,dos,mac
" I don't care if vim can't save viminfo
set viminfo+=!
" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.info,.aux,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc
" Try to find tags file withing current git repository
set tags+=.git/tags
" Load tree-specific vimrc
set exrc
" Run tree-specific vimrcs securelly
set secure

" }}}

" UI ----------------------------------------------------------------------- {{{

call vimrc#ui#setup()

" enable syntax highlight
syntax enable
syntax sync minlines=0
" colors! colors!
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
let g:rehash256 = 1
set background=dark
"colorscheme molokai
"colorscheme adventurous
colorscheme gruvbox
" show line numbers
set number
" highlight searches
set hlsearch
" always show cursor position
set ruler
" show current mode
set noshowmode
" show (partial) command in status line.
set showcmd
" enable mouse
if has('mouse')
  set mouse=a
endif
" no fucking bells!
set visualbell t_vb=
" status line always shown
set laststatus=2
" show wildcard completion menu
set wildmenu
" complete till longest match then open wildmenu
set wildmode=longest:full
" show at least 1 line of context when scrolling
set scrolloff=1
" show 5 columns of context when horizontal scrolling
set sidescrolloff=5
" show unprintable chars as hex
set display+=uhex
" show last line
set display+=lastline
" prettier listchars
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
  if &termencoding ==# 'utf-8' || &encoding ==# 'utf-8'
    let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u26ad"
    let &fillchars = "vert:\u259a,fold:\u00b7"
  endif
endif
" split to the right
set splitright
" split to the bottom
set splitbelow

" }}}

" Editing ------------------------------------------------------------------ {{{

" force ftdetect
filetype off
" file formats precedence
set fileformats=unix,mac,dos
" auto indentation on
set autoindent
" end of line
set endofline
" C auto indentation off
set nocindent
" don't expand tabs to spaces
set noexpandtab
" smart tabs
set smarttab
" timeout on mappings too
set ttimeout
set ttimeoutlen=50
" don't wrap lines
set nowrap
" don't show matching brackets
set noshowmatch
" allow backspacing over ai, line breaks, start of insert
set backspace=indent,eol,start
" don't scan included files on completion
set complete-=i
" completion options
set completeopt=menu,menuone,preview,noselect,noinsert
" allow line wrapping when moving cursor
set whichwrap=b,s,<,>,[,]
" format options
set formatoptions=tcroqlnj
" tab stop
set tabstop=2
" soft tab stop
set softtabstop=2
" shift width
set shiftwidth=2
" width of text
set textwidth=100
" mark the 100th column
let &colorcolumn = &textwidth
" remove '//' from comment auto-insert at a newline
set comments=s1:/*,mb:*,ex:*/,b:#,:%,:XCOMM,n:>,fb:-
" folding method
set foldmethod=marker
" ignore these files
set wildignore=*~,*.swp,*.o,*.so,*.dll,*.exe,*.class,*.obj,*.zip,*.tar*,*.bz2,*.7z,*.jpg,*.jpeg,*.png,*.gif,*.ico,*/.git,*/.svn,*/.hg,*.egg-info
set wildignorecase
" swap files directory
let &directory = g:vimrc#paths#vim_swap
" backup files directory
let &backupdir = g:vimrc#paths#vim_backup
" undo stuff
let &undodir = g:vimrc#paths#vim_undo
set undofile
set undolevels=1000
set undoreload=10000

" }}}
