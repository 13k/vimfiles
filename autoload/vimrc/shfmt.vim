fun! vimrc#shfmt#setup() abort
  if !exists(':Shfmt')
    return
  endif

  nmap <buffer> <Leader>P :Shfmt<CR>
endfun
