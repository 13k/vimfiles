fun! vimrc#yapf#setup() abort
  if !exists(':Yapf')
    return
  endif

  nmap <buffer> <Leader>P :Yapf<CR>

  if get(g:, 'vimrc#yapf#auto_format')
    augroup YapfAutoFormat
      au BufWritePre * call vimrc#yapf#autoFormat()
    augroup END
  endif
endfun

fun! vimrc#yapf#autoFormat()
  if &filetype ==# 'python'
    Yapf
  endif
endfun
