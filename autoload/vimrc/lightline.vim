let s:lightlineModes = {
  \   'ControlP': 'CtrlP',
  \   'vimfiler': 'VimFiler',
  \ }

fun! s:lightlineModes.default() abort
  return winwidth(0) > 60 ? lightline#mode() : ''
endfun

fun! vimrc#lightline#Mode() abort
  let l:fname = expand('%:t')

  if has_key(s:lightlineModes, l:fname)
    return get(s:lightlineModes, l:fname)
  endif

  return s:lightlineModes.default()
endfun

fun! vimrc#lightline#Readonly() abort
  return &filetype !~? 'help' && &readonly ? g:vimrc#lightline#readonly_icon : ''
endfun

fun! vimrc#lightline#Fugitive() abort
  if exists('*fugitive#head')
    let l:head = fugitive#head()
    return empty(l:head) ? '' : printf('%s %s', g:vimrc#lightline#fugitive_icon, l:head)
  endif

  return ''
endfun

fun! vimrc#lightline#Filename() abort
  if mode() ==# 't'
    return ''
  endif

  let l:fname = expand('%:t')

  if l:fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp')
    return g:lightline.ctrlp.item
  elseif &filetype ==# 'vimfiler'
    return vimfiler#get_status_string()
  else
    let l:llfn = ''

    if vimrc#lightline#Readonly() !=# ''
      let l:llfn = vimrc#lightline#Readonly() . ' '
    end

    let l:llfn .= (l:fname !=# '' ? l:fname : '[No Name]')

    if vimrc#lightline#Modified() !=# ''
      let l:llfn .= vimrc#lightline#Modified()
    endif

    return l:llfn
  end
endfun

fun! vimrc#lightline#Modified() abort
  return &modified ? g:vimrc#lightline#modified_icon : ''
endfun

fun! vimrc#lightline#CtrlPMark() abort
  if expand('%:t') ==# 'ControlP' && has_key(g:lightline, 'ctrlp')
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

fun! vimrc#lightline#Go() abort
  return exists('*go#statusline#Show') ? go#statusline#Show() : ''
endfun

fun! vimrc#lightline#FileFormatSymbol() abort
  return ''
  "return WebDevIconsGetFileFormatSymbol()
endfun

fun! vimrc#lightline#FileTypeSymbol() abort
  return ''
  "return WebDevIconsGetFileTypeSymbol()
endfun

fun! vimrc#lightline#FileFormat() abort
  if winwidth(0) <= 70 || empty(&fileformat)
    return ''
  endif

  return &fileformat . ' ' . vimrc#lightline#FileFormatSymbol()
endfun

fun! vimrc#lightline#FileType() abort
  if winwidth(0) <= 70
    return ''
  endif

  if empty(&filetype)
    return 'text'
  endif

  return &filetype . ' ' . vimrc#lightline#FileTypeSymbol()
endfun

fun! vimrc#lightline#FileEncoding() abort
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfun

fun! vimrc#lightline#LineInfo() abort
  return winwidth(0) > 60 ? printf('%3d:%-2d', line('.'), col('.')) : ''
endfun

fun! vimrc#lightline#Percent() abort
  return &filetype =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
endfun
