scriptencoding utf-8

" matchit {{{

packadd matchit

" }}}

" lightline {{{

let g:lightline = {
  \   'colorscheme': 'seoul256',
  \   'separator': { 'left': "\ue0c6", 'right': "\ue0c7" },
  \   'subseparator': { 'left': "\ue0bb", 'right': "\ue0bb" },
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
  \     'lineinfo': 'vimrc#lightline#LineInfo',
  \     'percent': 'vimrc#lightline#Percent',
  \     'modified': 'vimrc#lightline#Modified',
  \     'filename': 'vimrc#lightline#Filename',
  \     'fileformat': 'vimrc#lightline#FileFormat',
  \     'filetype': 'vimrc#lightline#FileType',
  \     'fileencoding': 'vimrc#lightline#FileEncoding',
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

let g:ctrlp_user_command = [
  \   '.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard',
  \ ]

let g:ctrlp_custom_ignore = {
  \   'dir': '\.git$\|\.yardoc\|public$|log\|tmp$',
  \   'file': '\.so$\|\.dat$|\.DS_Store$'
  \ }

" }}}

" gitgutter {{{

" disable when in diff or splice modes
if &diff || exists('g:splice_prefix')
  let g:gitgutter_enabled = 0
else
  let g:gitgutter_realtime = 1
  let g:gitgutter_eager = 1
  let g:gitgutter_map_keys = 0
end

" }}}

" splice {{{

let g:splice_wrap = 'nowrap'

" }}}

" splitjoin {{{

let g:splitjoin_ruby_hanging_args = 0
let g:splitjoin_ruby_trailing_comma = 1
let g:splitjoin_ruby_do_block_split = 1
let g:splitjoin_ruby_curly_braces = 0
let g:splitjoin_ruby_heredoc_type = '<<-'

" }}}

" editorconfig-vim {{{

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

call vimrc#editorconfig#setup()

" }}}

" ale {{{

" disable when in diff or splice modes
if &diff || exists('g:splice_prefix')
  let g:ale_enabled = 0
else
  " background colors matching SignColumn in `adventurous` colorscheme
  highlight ALEErrorSign ctermbg=234 ctermfg=DarkRed guibg=#1C1C1C guifg=#D3422E cterm=NONE gui=NONE
  highlight ALEWarningSign ctermbg=234 ctermfg=Yellow guibg=#1C1C1C guifg=#F5BB12 cterm=NONE gui=NONE

  let g:ale_fix_on_save = 1
  let g:ale_lint_on_enter = 1
  let g:ale_lint_on_filetype_changed = 1
  let g:ale_lint_on_insert_leave = 0
  let g:ale_lint_on_save = 1
  let g:ale_lint_on_text_changed = 'never'
  let g:ale_list_window_size = 3
  let g:ale_open_list = 0
  let g:ale_sign_column_always = 1
  let g:ale_sign_error = '>>'
  let g:ale_sign_warning = '--'

  let g:ale_fixers = {
    \   'c': ['clang-format'],
    \   'cpp': ['clang-format'],
    \   'css': ['prettier'],
    \   'elixir': ['mix_format'],
    \   'go': ['gofmt'],
    \   'graphql': ['prettier'],
    \   'javascript': ['prettier'],
    \   'less': ['prettier'],
    \   'python': ['black'],
    \   'ruby': ['rufo'],
    \   'scss': ['prettier'],
    \   'sh': ['shfmt'],
    \   'typescript': ['prettier'],
    \   'vue': ['prettier'],
    \ }

  let g:ale_linters = {
    \   'elixir': ['credo', 'mix'],
    \   'go': ['golangserver', 'golangci-lint'],
    \   'proto': ['protoc-gen-lint'],
    \   'python': ['pylint'],
    \   'ruby': ['brakeman', 'rails_best_practices', 'rubocop', 'ruby', 'rufo'],
    \   'vim': ['vint'],
    \ }

  let g:ale_ruby_rails_best_practices_executable = 'bundle'
  let g:ale_ruby_rubocop_executable = 'bundle'
  let g:ale_ruby_rufo_executable = 'bundle'

  let s:ale_stylelint_options = '--cache'
  let g:ale_css_stylelint_options = s:ale_stylelint_options
  let g:ale_less_stylelint_options = s:ale_stylelint_options
  let g:ale_sass_stylelint_options = s:ale_stylelint_options
  let g:ale_scss_stylelint_options = s:ale_stylelint_options
  let g:ale_stylus_stylelint_options = s:ale_stylelint_options

  augroup CloseLoclistWindowGroup
    autocmd!
    autocmd QuitPre * if empty(&buftype) | lclose | endif
  augroup END
endif

" }}}

" deoplete {{{

let g:deoplete#enable_at_startup = 0

" }}}

" vim-go {{{

let g:go_fmt_command = 'gofmt'
let g:go_fmt_autosave = 0
let g:go_info_mode = 'guru'

" }}}
