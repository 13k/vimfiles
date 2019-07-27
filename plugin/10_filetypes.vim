if !has('autocmd')
  finish
endif

augroup vimrc#filetype
  au FileType elixir call vimrc#elixir#setup()
  au FileType go call vimrc#go#setup()
augroup END
