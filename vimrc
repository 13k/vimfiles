" vim: et si sta ts=2 sts=2 sw=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:version < 700
  echoerr 'This vimrc requires Vim 7 or later.'
  quit
endif

" printf oriented debugging
fun s:debug(str)
  exec printf('redir >> %s', '/tmp/vim.log')
  silent echo a:str
  redir END
endfun

if v:version > 701 && &term != "cygwin"
  set term=builtin_xterm
endif

if has('multi_byte')
  " Legacy encoding is the system default encoding
  set encoding=utf-8
  let legacy_encoding=&encoding
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scripts/Plugins setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" force ftdetect
filetype off

" matchit
runtime macros/matchit.vim

" pathogen
runtime cache/bundles/vim-pathogen/autoload/pathogen.vim
call pathogen#infect('~/.vim/cache/bundles')

" fucking SQL ft plugin
let g:ftplugin_sql_omni_key_right = '<PageDown>'
let g:ftplugin_sql_omni_key_left = '<PageUp>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scripting
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" It's a common mistake to type the capital letter instead of the lowercased one
command W w
command Q q

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Do case insensitive matching
set ignorecase
" Turns off ignorecase when pattern contains upper case chars
set smartcase
" incremental search
set incsearch
" don't be compatible with vi!
set nocompatible
" don't save backups
set nobackup
" support this types of files in this order
set ffs=unix,dos,mac
" I don't care if vim can't save viminfo
set viminfo+=!
" Suffixes that get lower priority when doing tab completion for filenames.
set suffixes=.bak,~,.swp,.o,.info,.aux,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc
" Try to find tags file withing current git repository
set tags+=.git/tags

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax highlight
if &t_Co > 2 || has('gui_running')
  syntax enable
endif
" show line numbers
set number
" don't highlight searchs
set nohlsearch
" always show cursor position
set ruler
" show (partial) command in status line.
set showcmd
" background
set background=dark
" enable mouse
if has('mouse')
  set mouse=a
endif
" no fucking bells!
set vb t_vb=
" status line always shown
set laststatus=2
" status line
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y%{exists('g:loaded_fugitive')?fugitive#statusline():''}%{exists('g:loaded_rvm')?rvm#statusline():''}%=%-16(\ %l,%c-%v\ %)%P
" colors!
"let g:solarized_termtrans=1
colorscheme torte
" try to set the right window size
au GUIEnter * set lines=25 columns=85

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto indentation on
set autoindent
" end of line
set endofline
" C auto indentation off
set nocindent
" don't expand tabs to spaces
set noexpandtab
" no smart tab
set nosmarttab
" don't wrap lines
set nowrap
" show matching brackets.
set noshowmatch
" allow backspacing over ai, line breaks, start of insert
set backspace=indent,eol,start
" allow line wrapping when moving cursor
set whichwrap=b,s,<,>,[,]
" format options (comment leader, )
set formatoptions+=r
" tab stop
set tabstop=4
" soft tab stop
set softtabstop=4
" shift width
set shiftwidth=4
" no line wrap
set textwidth=0
" remove '//' from comment auto-insert at a newline
set comments=s1:/*,mb:*,ex:*/,b:#,:%,:XCOMM,n:>,fb:-
" folding method
set foldmethod=marker

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FileType customizations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('autocmd')
  " Enable filetype detection, plugins and indent files
  filetype plugin indent on

  " Django template ft detection
  fun! <SID>SniffAndSetDjangoTemplateFT()
    if search('{{.*}}') || search('{%.*%}')
      set ft=htmldjango
    endif
  endfun

  " Django python source ft detection
  fun! <SID>SniffAndSetDjangoPythonFT()
    if search('^\s*from\s\+django.*import') || search('^\s*import\s\+django')
      set ft=python.django
    endif
  endfun

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
  au FileType python call SniffAndSetDjangoPythonFT()
  au FileType python.django set et si sta ts=4 sts=4 sw=4
  au FileType html call SniffAndSetDjangoTemplateFT()
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

  " Enables trailing whitespace cleaning for all files
  au FileType * :call <SID>EnableStripTrailingWhitespaces()
  " Disable whitespace cleaning for markdown since it is valid markup
  au FileType markdown :call <SID>DisableStripTrailingWhitespaces()
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

runtime mappings.vim
