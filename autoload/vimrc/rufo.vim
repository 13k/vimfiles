fun! vimrc#rufo#setup() abort
  if !exists(':Rufo')
    return
  endif

  nmap <buffer> <Leader>P :Rufo<CR>
  vmap <buffer> <Leader>P :'<,'>Rufo<CR>
endfun
