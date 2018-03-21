fun! vimrc#paths#join(...)
  return join(a:000, '/')
endfun

fun! vimrc#paths#expired(path, max_age)
  return localtime() > (getftime(a:path) + a:max_age)
endfun

fun! vimrc#paths#touch(path)
  exe "silent !touch " . shellescape(a:path)
endfun

fun! vimrc#paths#setup()
  if exists('g:vimrc#paths#setup_once')
    return
  endif
  let g:vimrc#paths#setup_once = 1

  let g:vimrc#paths#xdg_cache_home = empty($XDG_CACHE_HOME) ? vimrc#paths#join($HOME, '.cache') : $XDG_CACHE_HOME
  let g:vimrc#paths#vim_cache = vimrc#paths#join(g:vimrc#paths#xdg_cache_home, 'vim')
  let g:vimrc#paths#vim_swap = vimrc#paths#join(g:vimrc#paths#vim_cache, 'swap')
  let g:vimrc#paths#vim_backup = vimrc#paths#join(g:vimrc#paths#vim_cache, 'backup')
  let g:vimrc#paths#vim_undo = vimrc#paths#join(g:vimrc#paths#vim_cache, 'undo')
  let g:vimrc#paths#vim = vimrc#paths#join($HOME, '.vim')
endfun
