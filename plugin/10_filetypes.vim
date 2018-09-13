if !has('autocmd')
  finish
endif

filetype plugin indent on

augroup vimrc#filetype
  au FileType elixir call vimrc#elixir#setup()
  au FileType go call vimrc#go#setup()
augroup END
