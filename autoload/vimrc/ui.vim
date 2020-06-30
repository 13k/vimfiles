let s:linux_fonts=[
  \ 'Cousine Nerd Font Mono 11',
  \ 'SauceCodePro Nerd Font 12',
  \ 'Operator Mono 12',
  \ 'Inconsolata 12',
  \ 'monospaced 10',
  \]

let s:mac_fonts = [
  \ 'Cousine Nerd Font Mono:h13',
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

function! vimrc#ui#setup() abort
  if exists('g:vimrc#ui#setup_once')
    return
  end

  let g:vimrc#ui#setup_once = 1

  call vimrc#ui#setup_colors()
  call vimrc#ui#setup_cursor()
  call vimrc#ui#setup_highlight()
endfunction

function! vimrc#ui#setup_colors() abort
  set background=dark

  if vimrc#platform#term_colors()
    set termguicolors
    set t_Co=256
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    let g:rehash256 = 1
  end

  if vimrc#plugins#plugins_installed()
    "colorscheme molokai
    "colorscheme adventurous
    colorscheme gruvbox
  else
    colorscheme desert
  end
endfunction

function! vimrc#ui#setup_cursor() abort
  if !vimrc#ui#gui()
    let &t_ti .= "\e[1 q"
    let &t_SI .= "\e[5 q"
    let &t_EI .= "\e[1 q"
    let &t_te .= "\e[0 q"
  end
endfunction

function! vimrc#ui#setup_highlight() abort
  augroup vimrc#ui#highlight
    autocmd ColorScheme * call vimrc#ui#highlight()
  augroup END
endfunction

function! vimrc#ui#setup_gui() abort
  if exists('g:vimrc#ui#setup_gui_once')
    return
  end
  let g:vimrc#ui#setup_gui_once = 1

  if !vimrc#ui#gui()
    return
  end

  if vimrc#ui#gui_mac()
    call call('vimrc#ui#set_font', s:mac_fonts)
  elseif vimrc#ui#gui_win32()
    call call('vimrc#ui#set_font', s:win32_fonts)
  else
    call call('vimrc#ui#set_font', s:linux_fonts)
  end

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
endfunction

function! vimrc#ui#gui() abort
  return vimrc#ui#gui_linux() ||
        \ vimrc#ui#gui_mac() ||
        \ vimrc#ui#gui_win32() ||
        \ vimrc#ui#gui_nvim()
endfunction

function! vimrc#ui#gui_linux() abort
  return has('linux') && has('gui_running')
endfunction

function! vimrc#ui#gui_mac() abort
  return has('mac') && (has('gui_macvim') || has('gui_vimr'))
endfunction

function! vimrc#ui#gui_win32() abort
  return has('win32') && has('gui_running')
endfunction

function! vimrc#ui#gui_nvim() abort
  return has('nvim') && exists('g:vimrc#ui#gui_nvim')
endfunction

function! vimrc#ui#set_font(...) abort
  let l:font = join(a:000, ',')

  if has('nvim')
    " nvim GUIs only support setting a single font with no fallbacks?
    call rpcnotify(1, 'Gui', 'Font', a:0)
  else
    let &guifont = l:font
  end
endfunction

function! vimrc#ui#highlight() abort
  " background colors matching SignColumn in `adventurous` colorscheme
  highlight ALEErrorSign ctermbg=234 ctermfg=DarkRed guibg=#1C1C1C guifg=#D3422E cterm=NONE gui=NONE
  highlight ALEWarningSign ctermbg=234 ctermfg=Yellow guibg=#1C1C1C guifg=#F5BB12 cterm=NONE gui=NONE

  if vimrc#ui#gui()
    call vimrc#ui#highlight_gui()
  else
    call vimrc#ui#highlight_tui()
  end
endfunction

function! vimrc#ui#highlight_tui() abort
  return
endfunction

function! vimrc#ui#highlight_gui() abort
  return
endfunction
