" Options
set guioptions=aei
" Always show tabline
set showtabline=2
" Always show status line
set laststatus=2
" Background
set background=light
" Font
if has('gui_macvim')
	set guifont=Menlo:h13,Monaco:h13
elseif has('win32')
  set guifont=Consolas:h12
else
	" set guifont=Aurulent\ Sans\ Mono\ 10,Droid\ Sans\ Mono\ 10,Monospaced\ 10
	set guifont=Source\ Code\ Pro\ For\ Powerline\ 10
endif
" Don't show file types in menu
let do_syntax_sel_menu=0
" Don't hide mouse
set nomousehide
" no fucking bells
set vb t_vb=
" Color scheme
colorscheme Monokai-Refined
" Number of lines and columns
set lines=30 columns=100
" try to set the right window size
autocmd GUIEnter * set lines=30 columns=100
autocmd VimEnter * set lines=30 columns=100
" try to fix gvim artifacts when scrolling/jumping around
"set ttyfast
"set ttyscroll=3
" override NERDTree mapping
nnoremap <F3> :set columns=160 <Bar> NERDTree<CR>
