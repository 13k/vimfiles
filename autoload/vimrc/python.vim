function! vimrc#python#setup() abort
  if exists('g:vimrc#python#setup_once')
    return
  end

  let g:vimrc#python#setup_once = 1

  if has('pythonx')
    set pyxversion=3
  end
endfunction
