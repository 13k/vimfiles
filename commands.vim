" It's a common mistake to type the capital letter instead of the lowercased one
command W w
command Q q

" Convert old-style Ruby hash syntax to new-style and properly format them
command -range RubyHashes <line1>,<line2>s/\v([^:]):(\w+)(\s*)\=\>/\1\2:/ge

" Strip trailing whitespace
fun! StripTrailingWhitespaces()
  if !&readonly && &modifiable
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endif
endfun

fun! EnableStripTrailingWhitespaces()
  aug StripTrailingWhitespaces
    au BufWritePre * :call StripTrailingWhitespaces()
  aug END
endfun

fun! DisableStripTrailingWhitespaces()
  aug StripTrailingWhitespaces
    au!
  aug END
endfun
