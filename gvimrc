" Background
set background=dark
" Font
if has('win32') || has('gui_macvim')
	set guifont=Mensch:h10,Menlo:h10,Consolas:h10,Monaco:h10
else
	set guifont=Envy\ Code\ R\ 11,M+\ 1m\ 11,Liberation\ Mono\ 10,Droid\ Sans\ Mono\ 10,DejaVu\ Sans\ Mono\ 10
endif
" Don't show file types in menu
let do_syntax_sel_menu=0
" no fucking bells
set vb t_vb=
" Color scheme
colorscheme jellybeans
" Number of lines and columns
set columns=100 lines=25
