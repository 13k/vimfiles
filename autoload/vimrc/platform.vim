function! vimrc#platform#is_linux() abort
  return has('linux')
endfunction

function! vimrc#platform#is_wsl() abort
  if !vimrc#platform#is_linux()
    return 0
  end

  return !empty(getenv("WSL_DISTRO_NAME"))
endfunction

function! vimrc#platform#is_xterm() abort
  return &term =~# '^xterm'
endfunction

function! vimrc#platform#term_colors() abort
  return &term =~# 'color'
endfunction
