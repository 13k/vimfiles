" Options
set guioptions=ai
" Always show tabline
set showtabline=2
" Background
set background=light
" Font
if has('win32') || has('gui_macvim')
	set guifont=Consolas:h10,Monaco:h10
else
	set guifont=Aurulent\ Sans\ Mono\ 10,Droid\ Sans\ Mono\ 10,Monospaced\ 10
endif
" Don't show file types in menu
let do_syntax_sel_menu=0
" no fucking bells
set vb t_vb=
" Color scheme
" colorscheme Tomorrow-Night
colorscheme solarized
set background=light
" Number of lines and columns
set lines=25 columns=85
" try to set the right window size
" autocmd GUIEnter * set lines=24 columns=85
" autocmd VimEnter * set lines=24 columns=85
