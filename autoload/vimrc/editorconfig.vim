function! vimrc#editorconfig#setup() abort
  if exists('g:vimrc#editorconfig#setup_once')
    return
  end

  let g:vimrc#editorconfig#setup_once = 1

  augroup vimrc#editorconfig#init
    au BufEnter * call vimrc#editorconfig#check()
  augroup END
endfunction

function! vimrc#editorconfig#check() abort
  let l:core_bin = get(g:, 'EditorConfig_exec_path')

  if l:core_bin == 0 || empty(l:core_bin)
    let l:core_bin = 'editorconfig'
  end

  if !executable(l:core_bin)
    call confirm('EditorConfig core is not installed, formatting will NOT happen')
  end
endfunction
