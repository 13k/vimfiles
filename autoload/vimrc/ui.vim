let s:linux_fonts=[
  \ 'Cousine Nerd Font Mono 11',
  \ 'SauceCodePro Nerd Font 12',
  \ 'Operator Mono 12',
  \ 'Inconsolata 12',
  \ 'monospaced 10',
  \]

let s:mac_fonts = [
  \ 'Cousine Nerd Font Mono:h11',
  \ 'SauceCodePro Nerd Font:h14',
  \ 'Operator Mono:h14',
  \ 'Monaco:h13',
  \]

let s:win32_fonts = [
  \ 'Cousine Nerd Font Mono:h11',
  \ 'SauceCodePro Nerd Font:h14',
  \ 'Operator Mono:h14',
  \ 'Consolas:h13',
  \]

fun! vimrc#ui#setup() abort
  if exists('g:vimrc#ui#setup_once')
    return
  endif
  let g:vimrc#ui#setup_once = 1

  augroup vimrc#ui#highlight
    autocmd ColorScheme * call vimrc#ui#highlight()
  augroup END
endfun

fun! vimrc#ui#setup_gui() abort
  if exists('g:vimrc#ui#setup_gui_once')
    return
  endif
  let g:vimrc#ui#setup_gui_once = 1

  if !vimrc#ui#gui()
    return
  endif

  if vimrc#ui#gui_mac()
    call call('vimrc#ui#set_font', s:mac_fonts)
  elseif vimrc#ui#gui_win32()
    call call('vimrc#ui#set_font', s:win32_fonts)
  else
    call call('vimrc#ui#set_font', s:linux_fonts)
  endif

  " Options
  set guioptions=aei
  " Always show tabline
  set showtabline=2
  " Always show status line
  set laststatus=2
  " Don't show file types in menu
  let g:do_syntax_sel_menu=0
  " Don't hide mouse
  set nomousehide
  " Number of lines and columns
  set lines=35 columns=140
  " Do not highlight current line under cursor
  set nocursorline
endfun

fun! vimrc#ui#gui() abort
  return vimrc#ui#gui_linux() ||
        \ vimrc#ui#gui_mac() ||
        \ vimrc#ui#gui_win32() ||
        \ vimrc#ui#gui_nvim()
endfun

fun! vimrc#ui#gui_linux() abort
  return has('linux') && has('gui_running')
endfun

fun! vimrc#ui#gui_mac() abort
  return has('mac') && (has('gui_macvim') || has('gui_vimr'))
endfun

fun! vimrc#ui#gui_win32() abort
  return has('win32') && has('gui_running')
endfun

fun! vimrc#ui#gui_nvim() abort
  return has('nvim') && exists('g:vimrc#ui#gui_nvim')
endfun

fun! vimrc#ui#set_font(...) abort
  let l:font = join(a:000, ',')

  if has('nvim')
    " nvim GUIs only support setting a single font with no fallbacks?
    call rpcnotify(1, 'Gui', 'Font', a:0)
  else
    let &guifont = l:font
  endif
endfun

fun! vimrc#ui#highlight() abort
  " background colors matching SignColumn in `adventurous` colorscheme
  highlight ALEErrorSign ctermbg=234 ctermfg=DarkRed guibg=#1C1C1C guifg=#D3422E cterm=NONE gui=NONE
  highlight ALEWarningSign ctermbg=234 ctermfg=Yellow guibg=#1C1C1C guifg=#F5BB12 cterm=NONE gui=NONE

  if vimrc#ui#gui()
    call vimrc#ui#highlight_gui()
  else
    call vimrc#ui#highlight_tui()
  endif
endfun

fun! vimrc#ui#highlight_tui() abort
  return
endfun

fun! vimrc#ui#highlight_gui() abort
  " Search
  highlight Search guibg=#4FC3F7 guifg=#212121
  " Cursor
  highlight Cursor guibg=#c0c0c0 guifg=#000000
  highlight iCursor guibg=#ffffff guifg=#000000
endfun
