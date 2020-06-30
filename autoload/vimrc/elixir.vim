function! vimrc#elixir#setup() abort
  if exists('g:vimrc#elixir#setup_once')
    return
  end

  let g:vimrc#elixir#setup_once = 1

  if get(g:, 'ale_enabled', 0) == 1
    let g:ale_lint_on_insert_leave = 0
    ALEDisable
    ALEEnable
  end
endfunction
