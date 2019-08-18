fun! vimrc#ale#setup() abort
  set omnifunc=ale#completion#OmniFunc

  augroup vimrc#ale#close_loclist
    autocmd!
    autocmd QuitPre * call vimrc#ale#close_loclist()
  augroup END
endfun

fun! vimrc#ale#close_loclist() abort
  if empty(&buftype)
    lclose
  endif
endfun
