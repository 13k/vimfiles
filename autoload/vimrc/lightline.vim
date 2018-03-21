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
  let icon = ''
  return &ft !~? 'help' && &readonly ? icon : ''
endfun

fun! vimrc#lightline#Fugitive()
  if exists('*fugitive#head')
    let icon = ''
    let head = fugitive#head()
    return strlen(head) ? printf("%s %s", icon, head) : ''
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
  return &modified ? '*' : ''
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

fun! vimrc#lightline#Fileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfun

fun! vimrc#lightline#Filetype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'plaintext') : ''
endfun

fun! vimrc#lightline#Fileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfun

fun! vimrc#lightline#Info()
  return winwidth(0) > 60 ? printf("%3d:%-2d", line('.'), col('.')) : ''
endfun

fun! vimrc#lightline#Percent()
  return &ft =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
endfun
