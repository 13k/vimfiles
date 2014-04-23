" vim: et si sta ts=2 sts=2 sw=2

" Setup -------------------------------------------------------------------- {{{

if v:version < 703
  echoerr 'This vimrc requires Vim 7.3 or later.'
  quit
endif

" freedesktop's xdg cache dir
let g:xdg_cache_dir = strlen($XDG_CACHE_HOME) > 0 ? $XDG_CACHE_HOME : $HOME . "/.cache"
let g:vim_cache_dir = g:xdg_cache_dir . "/vim"

" printf oriented debugging
fun s:debug(str)
  exec printf('redir >> %s', '/tmp/vim.log')
  silent echo a:str
  redir END
endfun

if has('multi_byte')
  " Legacy encoding is the system default encoding
  set encoding=utf-8
endif

" }}}

" Load Pathogen early ------------------------------------------------------ {{{

let g:bundles_dir = g:vim_cache_dir . "/bundles"
let s:pathogen_path = g:bundles_dir . "/vim-pathogen/autoload"
let &rtp = &rtp . "," . s:pathogen_path
runtime pathogen.vim
call pathogen#infect(g:bundles_dir . "/{}")
call pathogen#helptags()

" }}}

" General settings --------------------------------------------------------- {{{

" Do case insensitive matching
set ignorecase
" Turns off ignorecase when pattern contains upper case chars
set smartcase
" incremental search
set incsearch
" don't be compatible with vi!
set nocompatible
" support this types of files in this order
set ffs=unix,dos,mac
" I don't care if vim can't save viminfo
set viminfo+=!
" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.info,.aux,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc
" Try to find tags file withing current git repository
set tags+=.git/tags

" }}}

" UI ----------------------------------------------------------------------- {{{

" colors! colors!
set t_Co=256
" colors! colors!
colorscheme Tomorrow-Night
" enable syntax highlight
syntax enable
syntax sync minlines=0
" show line numbers
set number
" highlight searches
set hlsearch
" always show cursor position
set ruler
" show current mode
set showmode
" show (partial) command in status line.
set showcmd
" enable mouse
if has('mouse')
  set mouse=a
endif
" no fucking bells!
set vb t_vb=
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
set fileformats=unix,dos,mac
" auto indentation on
set autoindent
" end of line
set endofline
" C auto indentation off
set nocindent
" don't expand tabs to spaces
set noexpandtab
" no smart tab
set smarttab
" timeout on mappings too
set ttimeout
set ttimeoutlen=50
" don't wrap lines
set nowrap
" show matching brackets.
set noshowmatch
" allow backspacing over ai, line breaks, start of insert
set backspace=indent,eol,start
" do not scan included files on completion
set complete-=i
" allow line wrapping when moving cursor
set whichwrap=b,s,<,>,[,]
" format options (comment leader, )
set formatoptions+=r
" tab stop
set tabstop=2
" soft tab stop
set softtabstop=2
" shift width
set shiftwidth=2
" no line wrap
set textwidth=0
" remove '//' from comment auto-insert at a newline
set comments=s1:/*,mb:*,ex:*/,b:#,:%,:XCOMM,n:>,fb:-
" folding method
set foldmethod=marker
" ignore these files
set wildignore=*~,*.o,*.pyc,*.class,*.obj,.git,.svn,*.jpg,*.jpeg,*.png,*.gif
" mark the 80th column
set colorcolumn=80
" swap files directory
if isdirectory(g:vim_cache_dir . "/swap")
  let &directory = g:vim_cache_dir . "/swap"
endif
" backup files directory
if isdirectory(g:vim_cache_dir . "/backup")
  let &backupdir = g:vim_cache_dir . "/backup"
endif
" undo stuff
if isdirectory(g:vim_cache_dir . "/undo")
  let &undodir = g:vim_cache_dir . "/undo"
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

" }}}

" Scripts/Plugins setup ---------------------------------------------------- {{{

" matchit
runtime macros/matchit.vim

" nerdtree
let g:NERDTreeIgnore = ['\.sock$', '^\.git$[[dir]]']
for suffix in split(&suffixes, ',')
  let g:NERDTreeIgnore += [ escape(suffix, '.~') . '$' ]
endfor

" load powerline vim plugin
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup

" ack-vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" cmd-t
let g:CommandTWildIgnore=&wildignore . ",**/bower_components/*,app/assets/fonts/*,app/assets/images/*,log/*,tmp/*,vendor/*"

" }}}

" Scripting ---------------------------------------------------------------- {{{

" It's a common mistake to type the capital letter instead of the lowercased one
command W w
command Q q

" }}}

" FileType customizations -------------------------------------------------- {{{

if has('autocmd')
  runtime filetypes.vim
endif

" }}}

" Mappings ----------------------------------------------------------------- {{{

runtime mappings.vim

" }}}

" Commands ----------------------------------------------------------------- {{{

runtime commands.vim

" }}}

" GUI ---------------------------------------------------------------------- {{{

if has('gui_running')
  runtime gui.vim
endif

" }}}
