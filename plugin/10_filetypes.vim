if !has('autocmd')
  finish
endif

" Enable filetype detection, plugins and indent files
filetype plugin indent on

augroup FiletypeCustomization

  " AppleScript
  au BufNewFile,BufRead *.applescript set ft=applescript

  " Handlebars
  " Override filetype for handlebars+erb files
  au BufNewFile,BufRead *.hbs.erb,*.handlebars.erb,*.hb.erb set ft=handlebars

  " Jinja
  au BufNewFile,BufRead *.jinja,*.j2 set ft=jinja

  " Python
  au Filetype python call vimrc#yapf#setup()

  " Ruby
  au Filetype ruby call vimrc#rufo#setup()

  " C, C++, Obj-C, Protobuf
  au FileType c,cpp,objc,protobuf call vimrc#clang_format#setup()

  " Shell
  au Filetype sh call vimrc#shfmt#setup()

augroup END
