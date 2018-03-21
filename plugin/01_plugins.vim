" matchit
packadd matchit

let g:lightline = {
  \  'colorscheme': 'wombat',
  \  'active': {
  \    'left': [ [ 'mode', 'paste' ],
  \              [ 'fugitive', 'filename', 'go' ] ],
  \    'right': [ [ 'lineinfo' ],
  \               [ 'percent' ],
  \               [ 'fileformat', 'fileencoding', 'filetype' ] ]
  \  },
  \  'component_function': {
  \    'mode': 'LightLineMode',
  \    'lineinfo': 'LightLineInfo',
  \    'percent': 'LightLinePercent',
  \    'modified': 'LightLineModified',
  \    'filename': 'LightLineFilename',
  \    'fileformat': 'LightLineFileformat',
  \    'filetype': 'LightLineFiletype',
  \    'fileencoding': 'LightLineFileencoding',
  \    'fugitive': 'LightLineFugitive',
  \    'ctrlp_mark': 'LightLineCtrlPMark',
  \    'go': 'LightLineGo',
  \  },
  \}

let s:lightlineModes = {
  \ 'ControlP': 'CtrlP',
  \ 'vimfiler': 'VimFiler',
\}

function! s:lightlineModes.default()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightLineMode()
  let fname = expand('%:t')

  if has_key(s:lightlineModes, fname)
    return get(s:lightlineModes, fname)
  endif

  return s:lightlineModes.default()
endfunction

function! LightLineReadonly()
  let icon = ''
  return &ft !~? 'help' && &readonly ? icon : ''
endfunction

function! LightLineFugitive()
  if exists('*fugitive#head')
    let icon = ''
    let head = fugitive#head()
    return strlen(head) ? printf("%s %s", icon, head) : ''
  endif

  return ''
endfunction

function! LightLineFilename()
  if mode() == 't'
    return ''
  endif

  let fname = expand('%:t')

  if fname == 'ControlP' && has_key(g:lightline, 'ctrlp_item')
    return g:lightline.ctrlp_item
  elseif &ft == 'vimfiler'
    return vimfiler#get_status_string()
  else
    let llfn = ''

    if LightLineReadonly() != ''
      let llfn = LightLineReadonly() . ' '
    end

    let llfn .= (fname != '' ? fname : '[No Name]')

    if LightLineModified() != ''
      let llfn .= LightLineModified()
    endif

    return llfn
  end
endfunction

function! LightLineModified()
  return &modified ? '*' : ''
endfunction

" TODO: fix this
function! LightLineCtrlPMark()
  if expand('%:t') =~ 'ControlP'
    call lightline#link('iR'[g:lightline.ctrlp_regex])
    return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
          \ , g:lightline.ctrlp_next], 0)
  else
    return ''
  endif
endfunction

function! LightLineGo()
  return exists('*go#statusline#Show') ? go#statusline#Show() : ''
endfunction

function! LightLineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightLineFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'plaintext') : ''
endfunction

function! LightLineFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! LightLineInfo()
  return winwidth(0) > 60 ? printf("%3d:%-2d", line('.'), col('.')) : ''
endfunction

function! LightLinePercent()
  return &ft =~? 'vimfiler' ? '' : (100 * line('.') / line('$')) . '%'
endfunction

if exists('g:loaded_lightline')
  set noshowmode
endif

" gitgutter
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_map_keys = 0

" splice
let g:splice_wrap = "nowrap"

" vim-go
let g:go_fmt_command = "gofmt"
let g:go_fmt_autosave = 1

let g:go_info_mode = "guru"

" vim-clang-format
let g:clang_format_autosave = 0
let g:clang_format_fallback_style = "Google"

" vim-yapf
let g:yapf_style = "facebook"

" vim-ack
let g:ackprg = 'ag --vimgrep'

" editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" splitjoin
let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_trailing_comma = 1
let g:splitjoin_ruby_do_block_split = 1
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_heredoc_type = '<<-'

" deoplete
let g:deoplete#enable_at_startup = 0
