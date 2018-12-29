scriptencoding utf-8

" matchit {{{

packadd matchit

" }}}

" lightline {{{

let g:vimrc#lightline#readonly_icon = "\uf023" " ''
let g:vimrc#lightline#fugitive_icon = "\uf126" " ''
let g:vimrc#lightline#modified_icon = " \uf044" " '*'
let g:vimrc#lightline#separator_left = "\ue0c6"
let g:vimrc#lightline#separator_right = "\ue0c7"
let g:vimrc#lightline#subseparator_left = "\ue0bb"
let g:vimrc#lightline#subseparator_right = "\ue0bb"
let g:lightline#ale#indicator_checking = "\uf110 "
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

let g:lightline = {
  \   'colorscheme': 'seoul256',
  \   'separator': {
  \     'left': g:vimrc#lightline#separator_left,
  \     'right': g:vimrc#lightline#separator_right,
  \   },
  \   'subseparator': {
  \     'left': g:vimrc#lightline#subseparator_left,
  \     'right': g:vimrc#lightline#subseparator_right,
  \   },
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
  \       [ 'linter_checking', 'linter_ok', 'linter_errors', 'linter_warnings' ],
  \     ]
  \   },
  \   'component_type': {
  \     'linter_checking': 'left',
  \     'linter_ok': 'left',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \   },
  \   'component_expand': {
  \     'linter_checking': 'lightline#ale#checking',
  \     'linter_ok': 'lightline#ale#ok',
  \     'linter_warnings': 'lightline#ale#warnings',
  \     'linter_errors': 'lightline#ale#errors',
  \   },
  \   'component_function': {
  \     'mode': 'vimrc#lightline#mode',
  \     'lineinfo': 'vimrc#lightline#lineinfo',
  \     'percent': 'vimrc#lightline#percent',
  \     'modified': 'vimrc#lightline#modified',
  \     'filename': 'vimrc#lightline#filename',
  \     'fileformat': 'vimrc#lightline#fileformat',
  \     'filetype': 'vimrc#lightline#filetype',
  \     'fileencoding': 'vimrc#lightline#fileencoding',
  \     'fugitive': 'vimrc#lightline#fugitive',
  \     'ctrlp_mark': 'vimrc#lightline#ctrlp_mark',
  \     'go': 'vimrc#lightline#go',
  \   },
  \ }

if exists('g:loaded_lightline')
  set noshowmode
endif

" }}}

" ctrlp {{{

let g:ctrlp_status_func = {
  \   'main': 'vimrc#ctrlp#status_main',
  \   'prog': 'vimrc#ctrlp#status_prog',
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
  let g:ale_completion_enabled = 1
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
    \   'sh': ['shellcheck', 'language-server'],
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

  call vimrc#ale#setup()
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
