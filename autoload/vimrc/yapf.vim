fun! vimrc#yapf#setup() abort
  if !exists(':YAPF')
    return
  endif

  nmap <buffer> <Leader>P :YAPF<CR>
  vmap <buffer> <Leader>P :'<,'>YAPF<CR>

  augroup YapfAutoFormat
    au BufWritePre * call vimrc#yapf#autoFormat()
  augroup END
endfun

fun! vimrc#yapf#autoFormat()
  if &filetype ==# 'python' && get(g:, 'vimrc#yapf#auto_format')
    YAPF
  endif
endfun
