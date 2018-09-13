fun! vimrc#ui#setup() abort
  if exists('g:vimrc#ui#setup_once')
    return
  endif
  let g:vimrc#ui#setup_once = 1

  augroup vimrc#ui#highlight
    autocmd ColorScheme * call vimrc#ui#highlight()
  augroup END
endfun

fun! vimrc#ui#highlight() abort
  " background colors matching SignColumn in `adventurous` colorscheme
  highlight ALEErrorSign ctermbg=234 ctermfg=DarkRed guibg=#1C1C1C guifg=#D3422E cterm=NONE gui=NONE
  highlight ALEWarningSign ctermbg=234 ctermfg=Yellow guibg=#1C1C1C guifg=#F5BB12 cterm=NONE gui=NONE

  if has('gui_running')
    call vimrc#ui#highlight_gui()
  else
    call vimrc#ui#highlight_term()
  endif
endfun

fun! vimrc#ui#highlight_term() abort
  return
endfun

fun! vimrc#ui#highlight_gui() abort
  " Search
  highlight Search guibg=#4FC3F7 guifg=#212121
  " Cursor
  highlight Cursor guibg=#c0c0c0 guifg=#000000
  highlight iCursor guibg=#ffffff guifg=#000000
endfun
