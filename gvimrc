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
colorscheme darkZ
