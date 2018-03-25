let s:lightlineModes = {
  \ 'ControlP': 'CtrlP',
  \ 'vimfiler': 'VimFiler',
\}

fun! s:lightlineModes.default()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfun

fun! vimrc#lightline#Mode()
  let fname = expand('%:t')

  if has_key(s:lightlineModes, fname)
    return get(s:lightlineModes, fname)
  endif

  return s:lightlineModes.default()
endfun

fun! vimrc#lightline#Readonly()
  return &ft !~? 'help' && &readonly ? g:vimrc#lightline#readonly_icon : ''
endfun

fun! vimrc#lightline#Fugitive()
  if exists('*fugitive#head')
    let head = fugitive#head()
    return empty(head) ? '' : printf("%s %s", g:vimrc#lightline#fugitive_icon, head)
  endif

  return ''
endfun

fun! vimrc#lightline#Filename()
  if mode() == 't'
    return ''
  endif

  let fname = expand('%:t')

  if fname == 'ControlP' && has_key(g:lightline, 'ctrlp')
    return g:lightline.ctrlp.item
  elseif &ft == 'vimfiler'
    return vimfiler#get_status_string()
  else
    let llfn = ''

    if vimrc#lightline#Readonly() != ''
      let llfn = vimrc#lightline#Readonly() . ' '
    end

    let llfn .= (fname != '' ? fname : '[No Name]')

    if vimrc#lightline#Modified() != ''
      let llfn .= vimrc#lightline#Modified()
    endif

    return llfn
  end
endfun

fun! vimrc#lightline#Modified()
  return &modified ? g:vimrc#lightline#modified_icon : ''
endfun

fun! vimrc#lightline#CtrlPMark()
  if expand('%:t') == 'ControlP' && has_key(g:lightline, 'ctrlp')
    call lightline#link('iR'[g:lightline.ctrlp.regex])
    return lightline#concatenate(
      \   [
      \     g:lightline.ctrlp.prev,
      \     g:lightline.ctrlp.item,
      \     g:lightline.ctrlp.next,
      \   ],
      \   0
      \ )
  endif

  return ''
endfun

fun! vimrc#lightline#Go()
  return exists('*go#statusline#Show') ? go#statusline#Show() : ''
endfun

fun! vimrc#lightline#FileFormatSymbol()
  return ''
  "return WebDevIconsGetFileFormatSymbol()
endfun

fun! vimrc#lightline#FileTypeSymbol()
  return ''
  "return WebDevIconsGetFileTypeSymbol()
endfun

fun! vimrc#lightline#FileFormat()
  if winwidth(0) <= 70 || empty(&fileformat)
    return ''
  endif

  return &fileformat . ' ' . vimrc#lightline#FileFormatSymbol()
endfun

fun! vimrc#lightline#FileType()
  if winwidth(0) <= 70
    return ''
  endif

  if empty(&filetype)
    return 'text'
  endif

  return &filetype . ' ' . vimrc#lightline#FileTypeSymbol()
endfun

fun! vimrc#lightline#FileEncoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfun

fun! vimrc#lightline#LineInfo()
  return winwidth(0) > 60 ? printf("%3d:%-2d", line('.'), col('.')) : ''
endfun

fun! vimrc#lightline#Percent()
  return &ft =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
endfun