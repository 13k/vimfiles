let s:lightline_modes = {
  \   'ControlP': 'CtrlP',
  \   'vimfiler': 'VimFiler',
  \ }

function! s:lightline_modes.default() abort
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! vimrc#lightline#mode() abort
  let l:fname = expand('%:t')

  if has_key(s:lightline_modes, l:fname)
    return get(s:lightline_modes, l:fname)
  end

  return s:lightline_modes.default()
endfunction

function! vimrc#lightline#readonly() abort
  return &filetype !~? 'help' && &readonly ? g:vimrc#lightline#readonly_icon : ''
endfunction

function! vimrc#lightline#fugitive() abort
  if exists('*fugitive#head')
    let l:head = fugitive#head()
    return empty(l:head) ? '' : printf('%s %s', g:vimrc#lightline#fugitive_icon, l:head)
  end

  return ''
endfunction

function! vimrc#lightline#filename() abort
  if mode() ==# 't'
    return ''
  end

  let l:fname = expand('%:t')

  if l:fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp')
    return g:lightline.ctrlp.item
  elseif &filetype ==# 'vimfiler'
    return vimfiler#get_status_string()
  else
    let l:llfn = ''

    if vimrc#lightline#readonly() !=# ''
      let l:llfn = vimrc#lightline#readonly() . ' '
    end

    let l:llfn .= (l:fname !=# '' ? l:fname : '[No Name]')

    if vimrc#lightline#modified() !=# ''
      let l:llfn .= vimrc#lightline#modified()
    end

    return l:llfn
  end
endfunction

function! vimrc#lightline#modified() abort
  return &modified ? g:vimrc#lightline#modified_icon : ''
endfunction

function! vimrc#lightline#ctrlp_mark() abort
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
  end

  return ''
endfunction

function! vimrc#lightline#go() abort
  return exists('*go#statusline#Show') ? go#statusline#Show() : ''
endfunction

function! vimrc#lightline#fileformat_symbol() abort
  return ''
  "return WebDevIconsGetFileFormatSymbol()
endfunction

function! vimrc#lightline#filetype_symbol() abort
  "return ''
  return WebDevIconsGetFileTypeSymbol()
endfunction

function! vimrc#lightline#fileformat() abort
  if winwidth(0) <= 70 || empty(&fileformat)
    return ''
  end

  return &fileformat . ' ' . vimrc#lightline#fileformat_symbol()
endfunction

function! vimrc#lightline#filetype() abort
  if winwidth(0) <= 70
    return ''
  end

  if empty(&filetype)
    return 'text'
  end

  return &filetype . ' ' . vimrc#lightline#filetype_symbol()
endfunction

function! vimrc#lightline#fileencoding() abort
  return winwidth(0) > 70 ? (strlen(&fileencoding) ? &fileencoding : &encoding) : ''
endfunction

function! vimrc#lightline#lineinfo() abort
  return winwidth(0) > 60 ? printf('%3d:%-2d', line('.'), col('.')) : ''
endfunction

function! vimrc#lightline#percent() abort
  return &filetype =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
endfunction
