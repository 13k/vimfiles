fun! vimrc#clang_format#setup() abort
  if !exists(':ClangFormat')
    return
  endif

  nmap <buffer> <Leader>P :ClangFormat<CR>
  vmap <buffer> <Leader>P :'<,'>ClangFormat<CR>
endfun
