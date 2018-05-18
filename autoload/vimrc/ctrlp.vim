fun! vimrc#ctrlp#StatusMain(focus, byfname, regex, prev, item, next, marked) abort
  let g:lightline.ctrlp = {}
  let g:lightline.ctrlp.regex = a:regex
  let g:lightline.ctrlp.prev = a:prev
  let g:lightline.ctrlp.item = a:item
  let g:lightline.ctrlp.next = a:next
  return lightline#statusline(0)
endfun

fun! vimrc#ctrlp#StatusProg(str) abort
  return lightline#statusline(0)
endfun
