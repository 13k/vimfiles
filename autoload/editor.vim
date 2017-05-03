" Strip trailing whitespace
fun! editor#StripTrailingWhitespaces() abort
  if !&readonly && &modifiable
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endif
endfun

fun! editor#EnableStripTrailingWhitespaces() abort
  aug StripTrailingWhitespaces
    au BufWritePre * :call editor#StripTrailingWhitespaces()
  aug END
endfun

fun! editor#DisableStripTrailingWhitespaces() abort
  aug StripTrailingWhitespaces
    au!
  aug END
endfun
