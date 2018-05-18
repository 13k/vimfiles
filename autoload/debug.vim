" printf oriented debugging
fun! debug#print(str, ...) abort
  let l:output = a:0 == 0 ? '/tmp/vim-debug.log' : a:1
  exec printf('redir >> %s', l:output)
  silent echo a:str
  redir END
endfun
