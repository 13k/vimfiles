" matchit
packadd! matchit

" powerline
if has('pythonx')
  pyxfile $HOME/.vim/lib/python/powerline.py
endif

" cmd-t
let g:CommandTFileScanner = 'ruby'

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
