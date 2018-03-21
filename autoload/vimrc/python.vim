fun! vimrc#python#setup()
  if exists('g:vimrc#python#setup_once')
    return
  endif
  let g:vimrc#python#setup_once = 1

  if has('pythonx')
    set pyxversion=3
  endif

  " used by deoplete
  let g:python_host_prog = vimrc#paths#join($HOME, '.pyenv', 'versions', '2', 'bin', 'python')
  let g:python3_host_prog = vimrc#paths#join($HOME, '.pyenv', 'versions', '3', 'bin', 'python')
endfun
