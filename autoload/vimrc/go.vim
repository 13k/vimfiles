function! vimrc#go#setup() abort
  if exists('g:vimrc#go#setup_once')
    return
  end

  let g:vimrc#go#setup_once = 1

  nnoremap <buffer> <leader>i :GoInfo<cr>
  nnoremap <buffer> <leader>p :GoImports<cr>
  nnoremap <buffer> <leader>r :GoRename<cr>
endfunction
