if !has('autocmd')
  finish
endif

" Enable filetype detection, plugins and indent files
filetype plugin indent on

augroup FiletypeDetection

  " AppleScript
  au BufNewFile,BufRead *.applescript set ft=applescript

  " Handlebars
  " Override filetype for handlebars+erb files
  au BufNewFile,BufRead *.hbs.erb,*.handlebars.erb,*.hb.erb set ft=handlebars

  " Jinja
  au BufNewFile,BufRead *.jinja,*.j2 set ft=jinja

augroup END
