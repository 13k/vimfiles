" Enable filetype detection, plugins and indent files
filetype plugin indent on

" Strip trailing whitespace
fun! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

fun! <SID>EnableStripTrailingWhitespaces()
  aug StripTrailingWhitespaces
    au BufWritePre * :call <SID>StripTrailingWhitespaces()
  aug END
endfun

fun! <SID>DisableStripTrailingWhitespaces()
  aug StripTrailingWhitespaces
    au!
  aug END
endfun

fun! <SID>SetRailsIgnores()
  let ignored = ['doc/app', 'coverage', 'log', 'solr', 'tmp', 'vendor', 'public/uploads', 'app/assets/images', 'app/assets/fonts']
  for subdir in ignored
    let &wildignore = &wildignore . "," . subdir
  endfor
endfun

" CoffeeScript
au FileType coffee set et si sta ts=2 sts=2 sw=2
" C++
au FileType cpp set et si sta ts=4 sts=4 sw=4
" CSS
au FileType css set et si sta ts=2 sts=2 sw=2
" SCSS
au FileType scss set et si sta ts=2 sts=2 sw=2
" LESS
au FileType less set et si sta ts=2 sts=2 sw=2
" Python
au FileType python set et si sta ts=4 sts=4 sw=4
" Django
au FileType python.django set et si sta ts=4 sts=4 sw=4
au FileType htmldjango set et si sta ts=4 sts=4 sw=4
" Ruby
au FileType ruby set et si sta ts=2 sts=2 sw=2
" Erb
au FileType eruby set et si sta ts=2 sts=2 sw=2
" Slim
au FileType slim set et si sta ts=2 sts=2 sw=2
" Jade
au FileType jade set et si sta ts=2 sts=2 sw=2
" (X)HTML
au FileType html set et si sta ts=2 sts=2 sw=2
au FileType xhtml set et si sta ts=2 sts=2 sw=2
" XML
au FileType xml set et si sta ts=4 sts=4 sw=4
" JavaScript
au FileType javascript set et si sta ts=2 sts=2 sw=2
" PHP
au FileType php set et si sta ts=4 sts=4 sw=4
au FileType phtml set filetype=php
" YAML
au FileType yaml set et si sta ts=2 sts=2 sw=2
" Java
au FileType java set et si sta ts=4 sts=4 sw=4
" Scala
au FileType scala set et si sta ts=2 sts=2 sw=2
" Groovy
au FileType groovy set et si sta ts=2 sts=2 sw=2
" Shell
au FileType sh set et si sta ts=2 sts=2 sw=2
" viml
au FileType vim set et si sta ts=2 sts=2 sw=2

" Override filetype for handlebars+erb files
au BufNewFile,BufRead *.hbs.erb,*.handlebars.erb,*.hb.erb set ft=handlebars

" Detect/override .enj, .enjoei files (ERB templates)
au BufNewFile,BufRead *.enj,*.enjoei set ft=eruby

" Enables trailing whitespace cleaning for all files
au FileType * :call <SID>EnableStripTrailingWhitespaces()
" Disable whitespace cleaning for markdown since it is valid markup
au FileType markdown :call <SID>DisableStripTrailingWhitespaces()

" Sets rails wildignore
"au FileType ruby :call <SID>SetRailsIgnores()
