fun! vimrc#elixir#setup() abort
  if get(g:, 'ale_enabled', 0) == 1
    let g:ale_lint_on_insert_leave = 0
    ALEDisable
    ALEEnable
  endif
endfun
