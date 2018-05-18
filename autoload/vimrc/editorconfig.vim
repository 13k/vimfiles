fun! vimrc#editorconfig#setup() abort
  augroup EditorConfigInit
    au BufEnter * call vimrc#editorconfig#check()
  augroup END
endfun

fun! vimrc#editorconfig#check() abort
  let l:core_bin = get(g:, 'EditorConfig_exec_path')

  if l:core_bin == 0 || empty(l:core_bin)
    let l:core_bin = 'editorconfig'
  endif

  if !executable(l:core_bin)
    call confirm('EditorConfig core is not installed, formatting will NOT happen')
  endif
endfun
