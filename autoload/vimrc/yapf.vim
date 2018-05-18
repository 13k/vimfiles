fun! vimrc#yapf#setup() abort
  nmap <Leader>P :YAPF<CR>
  vmap <Leader>P :'<,'>YAPF<CR>
  imap <C-Y> <c-o>:call yapf#YAPF()<CR>
endfun
