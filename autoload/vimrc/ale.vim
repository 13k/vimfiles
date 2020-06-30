function! vimrc#ale#setup() abort
  if exists('g:vimrc#ale#setup_once')
    return
  end

  let g:vimrc#ale#setup_once = 1

  set omnifunc=ale#completion#OmniFunc

  augroup vimrc#ale#close_loclist
    autocmd!
    autocmd QuitPre * call vimrc#ale#close_loclist()
  augroup END
endfunction

function! vimrc#ale#close_loclist() abort
  if empty(&buftype)
    lclose
  end
endfunction
