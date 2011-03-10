" vim: et si sta ts=2 sts=2 sw=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:version < 700
  echoerr 'This vimrc requires Vim 7 or later.'
  quit
endif

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
" pathogen. adds ~/.vim/bundle to rtp
call pathogen#runtime_append_all_bundles()

" fucking SQL ft plugin
let g:ftplugin_sql_omni_key_right = '<PageDown>'
let g:ftplugin_sql_omni_key_left = '<PageUp>'

" command-T
let g:CommandTMaxHeight=5

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" enable syntax highlight
if &t_Co > 2 || has('gui_running')
  syntax on
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
"set bg=dark
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
colorscheme darkZ

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" auto indentation on
set autoindent
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Navigate forward and back inside tabs with Shift+Left and Shift+Right
map <silent><S-Right> :tabnext<CR>
map <silent><S-Left> :tabprevious<CR>
" Map CTRL+] and CTRL+T to CTRL+LeftArrow and CTRL+RightArrow
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FileType customizations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has('autocmd')
  " Enable filetype detection, plugins and indent files
  filetype plugin indent on

  " Django template ft detection
  function SniffAndSetDjangoTemplateFT()
    if search('{{.*}}') || search('{%.*%}')
      set ft=html.django_template
      set syntax=htmldjango
    endif
  endf

  " Django python source ft detection
  function SniffAndSetDjangoPythonFT()
    if search('^\s*from\s\+django.*import') || search('^\s*import.*django')
      set ft=python.django
      set syntax=python
    endif
  endf

  " C++
  au FileType cpp set et si sta ts=4 sts=4 sw=4
  " CSS
  au FileType css set et si sta ts=2 sts=2 sw=2
  " Python
  au FileType python set et si sta ts=2 sts=2 sw=2
  au FileType python call SniffAndSetDjangoPythonFT()
  au FileType python.django set et si sta ts=2 sts=2 sw=2
  " Ruby
  au FileType ruby set et si sta ts=2 sts=2 sw=2
  " Erb
  au FileType eruby set et si sta ts=2 sts=2 sw=2
  " Slim
  au FileType slim set et si sta ts=2 sts=2 sw=2
  " (X)HTML
  au FileType html set et si sta ts=2 sts=2 sw=2
  au FileType xhtml set et si sta ts=2 sts=2 sw=2
  au FileType html call SniffAndSetDjangoTemplateFT()
  au FileType html.django_template set et si sta ts=2 sts=2 sw=2
  " JavaScript
  au FileType javascript set et si sta ts=2 sts=2 sw=2
  " PHP
  au FileType php set noet si sta ts=4 sts=4 sw=4
  au FileType phtml set filetype=php
  " YAML
  au FileType yaml set et si sta ts=2 sts=2 sw=2
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun HamlHashToDottedClass()
  :s@{\s*:class\s*=>\s*["']\(.\{-}\)['"]\s*}@<HAML_CLASSES>\1</HAML_CLASSES>@
  :s@<HAML_CLASSES>\(.\{-}\)</HAML_CLASSES>@\="." . substitute(submatch(1), "\\s\\+", ".", "g")
endfun
