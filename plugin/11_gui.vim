if !has('gui_running')
  finish
endif

" Options
set guioptions=aei
" Always show tabline
set showtabline=2
" Always show status line
set laststatus=2
" Font
if has('gui_macvim') || has('gui_vimr')
  "set guifont=Operator\ Mono\ Light:h14,Source\ Code\ Pro\ Light:h14,Hack\ Regular:h14,Monaco:h13
  set guifont=SauceCodePro\ Nerd\ Font:h14,Monaco:h13
elseif has('win32')
  set guifont=Operator\ Mono:h13,Source\ Code\ Pro\ Light:h13,Hack\ Regular:h13,Consolas:h12
else
  "set guifont=Operator\ Mono\ weight=330\ 12,Source\ Code\ Pro\ 12,Hack\ Regular\ 12,Inconsolata\ 12,Monospaced\ 10
  set guifont=SauceCodePro\ Nerd\ Font\ 12,Inconsolata\ 12,monospaced\ 10
endif
" Don't show file types in menu
let do_syntax_sel_menu=0
" Don't hide mouse
set nomousehide
" no fucking bells
set vb t_vb=
" Number of lines and columns
set lines=30 columns=115
" Do not highlight current line under cursor
set nocursorline
" Search
highlight Search guibg=#4FC3F7 guifg=#212121
" Cursor
highlight Cursor guibg=#c0c0c0 guifg=#000000
highlight iCursor guibg=#ffffff guifg=#000000
