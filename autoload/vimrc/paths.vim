function! vimrc#paths#join(...) abort
  return join(a:000, '/')
endfunction

function! vimrc#paths#exists(path) abort
  return !empty(getftype(a:path))
endfunction

function! vimrc#paths#is_expired(path, max_age) abort
  return localtime() > (getftime(a:path) + a:max_age)
endfunction

function! vimrc#paths#write_timestamp(path) abort
  return writefile([localtime()], a:path, 's')
endfunction

function! vimrc#paths#setup() abort
  if exists('g:vimrc#paths#setup_once')
    return
  end

  let g:vimrc#paths#setup_once = 1

  let g:vimrc#paths#xdg_config_home = empty($XDG_CONFIG_HOME) ? vimrc#paths#join($HOME, '.config') : $XDG_CONFIG_HOME
  let g:vimrc#paths#xdg_cache_home = empty($XDG_CACHE_HOME) ? vimrc#paths#join($HOME, '.cache') : $XDG_CACHE_HOME
  let g:vimrc#paths#xdg_data_home = empty($XDG_DATA_HOME) ? vimrc#paths#join($HOME, '.local', 'share') : $XDG_DATA_HOME

  let g:vimrc#paths#vim_cache = vimrc#paths#join(g:vimrc#paths#xdg_cache_home, 'vim')
  let g:vimrc#paths#vim_swap = vimrc#paths#join(g:vimrc#paths#vim_cache, 'swap')
  let g:vimrc#paths#vim_backup = vimrc#paths#join(g:vimrc#paths#vim_cache, 'backup')
  let g:vimrc#paths#vim_undo = vimrc#paths#join(g:vimrc#paths#vim_cache, 'undo')
  let g:vimrc#paths#vim = vimrc#paths#join($HOME, '.vim')

  let g:vimrc#paths#nvim_cache = vimrc#paths#join(g:vimrc#paths#xdg_data_home, 'nvim')
  let g:vimrc#paths#nvim = vimrc#paths#join(g:vimrc#paths#xdg_config_home, 'nvim')
endfunction
