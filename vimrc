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

" Scripts/Plugins setup ---------------------------------------------------- {{{

" force ftdetect
filetype off

" matchit
runtime macros/matchit.vim

" nerdtree
let g:NERDTreeIgnore = ['\.sock$', '^\.git$[[dir]]']
for suffix in split(&suffixes, ',')
  let g:NERDTreeIgnore += [ escape(suffix, '.~') . '$' ]
endfor

" pathogen
let g:bundles_dir = g:vim_cache_dir . "/bundles"
let s:pathogen_path = g:bundles_dir . "/vim-pathogen/autoload"
let &rtp = &rtp . "," . s:pathogen_path
runtime pathogen.vim
call pathogen#infect(g:bundles_dir . "/{}")
call pathogen#helptags()

" ack-vim
let g:ackprg = 'ag --nogroup --nocolor --column'

" }}}

" Scripting ---------------------------------------------------------------- {{{

" It's a common mistake to type the capital letter instead of the lowercased one
command W w
command Q q

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
" status line
" set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{exists('g:loaded_fugitive')?fugitive#statusline():''}%=%-16(\ %l,%c-%v\ %)%P
" load powerline vim plugin
let &rtp = &rtp . "," . g:bundles_dir . "/powerline/powerline/bindings/vim/plugin"
runtime powerline.vim
" split to the right
set splitright
" split to the bottom
set splitbelow

" }}}

" Editing ------------------------------------------------------------------ {{{

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
set wildignore=*~,*.o,*.pyc,*.class,*.obj,.git,.svn,doc/app,coverage,log,solr,tmp,vendor,public/uploads,app/assets/images,app/assets/fonts
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

" FileType customizations -------------------------------------------------- {{{

if has('autocmd')
  " Enable filetype detection, plugins and indent files
  filetype plugin indent on

  " Strip trailing whitespace
  fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun

  fun! <SID>EnableStripTrailingWhitespaces()
    aug StripTrailingWhitespaces
      au BufWritePre * :call <SID>StripTrailingWhitespaces()
    aug END
  endfun

  fun! <SID>DisableStripTrailingWhitespaces()
    aug StripTrailingWhitespaces
      au!
    aug END
  endfun

  " CoffeeScript
  au FileType coffee set et si sta ts=2 sts=2 sw=2
  " C++
  au FileType cpp set et si sta ts=4 sts=4 sw=4
  " CSS
  au FileType css set et si sta ts=2 sts=2 sw=2
  " SCSS
  au FileType scss set et si sta ts=2 sts=2 sw=2
  " LESS
  au FileType less set et si sta ts=2 sts=2 sw=2
  " Python
  au FileType python set et si sta ts=4 sts=4 sw=4
  " Django
  au FileType python.django set et si sta ts=4 sts=4 sw=4
  au FileType htmldjango set et si sta ts=4 sts=4 sw=4
  " Ruby
  au FileType ruby set et si sta ts=2 sts=2 sw=2
  " Erb
  au FileType eruby set et si sta ts=2 sts=2 sw=2
  " Slim
  au FileType slim set et si sta ts=2 sts=2 sw=2
  " Jade
  au FileType jade set et si sta ts=2 sts=2 sw=2
  " (X)HTML
  au FileType html set et si sta ts=2 sts=2 sw=2
  au FileType xhtml set et si sta ts=2 sts=2 sw=2
  " XML
  au FileType xml set et si sta ts=4 sts=4 sw=4
  " JavaScript
  au FileType javascript set et si sta ts=2 sts=2 sw=2
  " PHP
  au FileType php set et si sta ts=4 sts=4 sw=4
  au FileType phtml set filetype=php
  " YAML
  au FileType yaml set et si sta ts=2 sts=2 sw=2
  " Java
  au FileType java set et si sta ts=4 sts=4 sw=4
  " Scala
  au FileType scala set et si sta ts=2 sts=2 sw=2
  " Groovy
  au FileType groovy set et si sta ts=2 sts=2 sw=2
  " Shell
  au FileType sh set et si sta ts=2 sts=2 sw=2
  " viml
  au FileType vim set et si sta ts=2 sts=2 sw=2

  " Override filetype for handlebars+erb files
  au BufNewFile,BufRead *.hbs.erb,*.handlebars.erb,*.hb.erb set ft=handlebars

  " Detect/override .enj, .enjoei files (ERB templates)
  au BufNewFile,BufRead *.enj,*.enjoei set ft=eruby

  " Enables trailing whitespace cleaning for all files
  au FileType * :call <SID>EnableStripTrailingWhitespaces()
  " Disable whitespace cleaning for markdown since it is valid markup
  au FileType markdown :call <SID>DisableStripTrailingWhitespaces()
endif

" }}}

" Mappings ----------------------------------------------------------------- {{{

runtime mappings.vim

" }}}

" Commands ----------------------------------------------------------------- {{{

runtime commands.vim

" }}}
