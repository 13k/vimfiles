fun! vimrc#platform#is_linux() abort
  return has('linux')
endfun

fun! vimrc#platform#is_wsl() abort
  if !vimrc#platform#is_linux()
    return 0
  endif

  return !empty(getenv("WSL_DISTRO_NAME"))
endfun

fun! vimrc#platform#is_xterm() abort
  return &term =~# '^xterm'
endfun
