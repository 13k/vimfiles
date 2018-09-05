if !has('autocmd')
  finish
endif

filetype plugin indent on

augroup FiletypeCustomization
  au FileType c,cpp,objc,protobuf call vimrc#clang_format#setup()
  au FileType elixir call vimrc#elixir#setup()
  au FileType go call vimrc#go#setup()
  au FileType python call vimrc#yapf#setup()
  au FileType ruby call vimrc#rufo#setup()
  au FileType sh call vimrc#shfmt#setup()
augroup END
