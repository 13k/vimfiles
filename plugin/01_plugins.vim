" matchit {{{

packadd matchit

" }}}

" lightline {{{
let g:lightline = {
  \   'colorscheme': 'seoul256',
  \   'separator': { 'left': '', 'right': '' },
  \   'subseparator': { 'left': '', 'right': '' },
  \   'active': {
  \     'left': [
  \       [ 'mode', 'paste' ],
  \       [ 'fugitive' ],
  \       [ 'filename' ],
  \       [ 'ctrlp_mark', 'go' ],
  \     ],
  \     'right': [
  \       [ 'lineinfo' ],
  \       [ 'filetype', 'fileformat', 'fileencoding', ],
  \       [ 'linter_checking', 'linter_errors', 'linter_warnings' ],
  \     ]
  \   },
  \   'component_type': {
  \     'linter_checking': 'left',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'left',
  \   },
  \   'component_expand': {
  \     'linter_checking': 'lightline#ale#checking',
  \     'linter_warnings': 'lightline#ale#warnings',
  \     'linter_errors': 'lightline#ale#errors',
  \     'linter_ok': 'lightline#ale#ok',
  \   },
  \   'component_function': {
  \     'mode': 'vimrc#lightline#Mode',
  \     'lineinfo': 'vimrc#lightline#Info',
  \     'percent': 'vimrc#lightline#Percent',
  \     'modified': 'vimrc#lightline#Modified',
  \     'filename': 'vimrc#lightline#Filename',
  \     'fileformat': 'vimrc#lightline#Fileformat',
  \     'filetype': 'vimrc#lightline#Filetype',
  \     'fileencoding': 'vimrc#lightline#Fileencoding',
  \     'fugitive': 'vimrc#lightline#Fugitive',
  \     'ctrlp_mark': 'vimrc#lightline#CtrlPMark',
  \     'go': 'vimrc#lightline#Go',
  \   },
  \ }

let g:vimrc#lightline#readonly_icon = "\uf023" " ''
let g:vimrc#lightline#fugitive_icon = "\uf126" " ''
let g:vimrc#lightline#modified_icon = " \uf044" " '*'
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

if exists('g:loaded_lightline')
  set noshowmode
endif

" }}}

" ctrlp {{{
let g:ctrlp_status_func = {
  \   'main': 'vimrc#ctrlp#StatusMain',
  \   'prog': 'vimrc#ctrlp#StatusProg',
  \ }

" }}}

" gitgutter {{{
let g:gitgutter_realtime = 1
let g:gitgutter_eager = 1
let g:gitgutter_map_keys = 0

" }}}

" splice {{{

let g:splice_wrap = "nowrap"

" }}}

" vim-go {{{

let g:go_fmt_command = "gofmt"
let g:go_fmt_autosave = 1

let g:go_info_mode = "guru"

" }}}

" vim-clang-format {{{

let g:clang_format_autosave = 0
let g:clang_format_fallback_style = "Google"

" }}}

" vim-yapf {{{

let g:yapf_style = "facebook"

" }}}

" vim-ack {{{

let g:ackprg = 'ag --vimgrep'

" }}}

" editorconfig-vim {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" }}}

" splitjoin {{{

let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_trailing_comma = 1
let g:splitjoin_ruby_do_block_split = 1
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_heredoc_type = '<<-'

" }}}

" ale {{{

let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" background colors matching SignColumn in `adventurous` colorscheme
highlight ALEErrorSign ctermbg=234 ctermfg=DarkRed guibg=#1C1C1C guifg=#D3422E cterm=NONE gui=NONE
highlight ALEWarningSign ctermbg=234 ctermfg=Yellow guibg=#1C1C1C guifg=#F5BB12 cterm=NONE gui=NONE

" }}}

" deoplete {{{

let g:deoplete#enable_at_startup = 0

" }}}
