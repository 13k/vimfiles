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
	set guifont=Sauce\ Code\ Powerline\ Light:h13,Monaco:h13
elseif has('win32')
  set guifont=Sauce\ Code\ Powerline:h13,Consolas:h12
else
	set guifont=Sauce\ Code\ Powerline\ 10,Monospaced\ 10
endif
" Don't show file types in menu
let do_syntax_sel_menu=0
" Don't hide mouse
set nomousehide
" no fucking bells
set vb t_vb=
" Color scheme
colorscheme Tomorrow-Night-Eighties
" Number of lines and columns
set lines=30 columns=115
" Do not highlight current line under cursor
set nocursorline
