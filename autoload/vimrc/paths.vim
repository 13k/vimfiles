fun! vimrc#paths#join(...) abort
  return join(a:000, '/')
endfun

fun! vimrc#paths#isExpired(path, max_age) abort
  return localtime() > (getftime(a:path) + a:max_age)
endfun

fun! vimrc#paths#writeTimestamp(path) abort
  return writefile([localtime()], a:path, 'ws')
endfun

fun! vimrc#paths#setup() abort
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
