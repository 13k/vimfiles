" vim:noexpandtab shiftwidth=4 tabstop=4

" k's vimrc for Vim 7
" Last Change: Sun Jun 21 10:53:41 BRT 2009

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if v:version < 700
	echoerr 'This vimrc requires Vim 7 or later.'
	quit
endif

if has('autocmd')
	" Remove ALL autocommands for the current group
	au!
	" Enable filetype detection, plugins and indent files
	filetype plugin indent on
	" reads rc in current directory
	set exrc
endif

if has('multi_byte')
  " Legacy encoding is the system default encoding
  set encoding=utf-8
  let legacy_encoding=&encoding
endif

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
syntax on

" show line numbers
set number
" don't highlight searchs
set nohlsearch
" always show cursor position
set ruler
" show (partial) command in status line.
set showcmd
" background
set bg=dark
" enable mouse
set mouse=a
" no fucking bells!
set vb t_vb=
" GUI
if has('gui_running')
	" Font
	if has('win32')
		set guifont=Consolas:h10,Inconsolata:h11,DejaVu\ Sans\ Mono:h10
	else
		set guifont=Inconsolata\ 11,DejaVu\ Sans\ Mono\ 10
	endif

	" Number of lines and columns (window height and width)
	if &diff
		set columns=150 lines=30
	else
		set columns=100 lines=25
	endif

	" Don't show file types in menu
	let do_syntax_sel_menu=0

	" Color scheme
	colorscheme desert
else
	colorscheme desert
endif

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
" Scripts/Plugins initializations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" pathogen. adds ~/.vim/bundle to rtp
call pathogen#runtime_append_all_bundles()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FileType customizations
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

" Python
au FileType python set et si sta ts=4 sts=4 sw=4
au FileType python call SniffAndSetDjangoPythonFT()
au FileType python.django set et si sta ts=4 sts=4 sw=4
" Ruby
au FileType ruby set et si sta ts=2 sts=2 sw=2
" Erb
au FileType eruby set et si sta ts=2 sts=2 sw=2
" Markdown
au FileType mkd set ai formatoptions=tcroqn2 comments=n:>
" HTML
au FileType html set si sta ts=2 sts=2 sw=2
au FileType html call SniffAndSetDjangoTemplateFT()
au FileType html.django_template set si sta ts=2 sts=2 sw=2
" PHP
au FileType php set et si sta ts=4 sts=4 sw=4

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Helper Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
fun HamlHashToDottedClass()
	:s@{\s*:class\s*=>\s*["']\(.\{-}\)['"]\s*}@<HAML_CLASSES>\1</HAML_CLASSES>@
	:s@<HAML_CLASSES>\(.\{-}\)</HAML_CLASSES>@\="." . substitute(submatch(1), "\\s\\+", ".", "g")
endfun

fun CssComment()
	:s@^\(\s*\)\(.*\)$@\1/*\2*/@
endfun

fun CssUncomment()
	:s@^\(\s*\)/\*\(.*\)\*/$@\1\2@
endfun

fun ToggleCssComment()
	if (match(getline("."), "\s*/\\*.*\\*/") > -1)
		call CssUncomment()
	else
		call CssComment()
	end
endfun
