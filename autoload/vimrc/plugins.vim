fun! vimrc#plugins#setup() abort
  if exists('g:vimrc#plugins#setup_once')
    return
  endif
  let g:vimrc#plugins#setup_once = 1

  let g:vimrc#plugins#plugged_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plugged')
  let g:vimrc#plugins#plug_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plug')
  let g:vimrc#plugins#plug_update_interval = 5 * 24 * 3600 " 5 days

  let s:plug_script_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'autoload', 'plug.vim')
  let s:plug_timestamp_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'last_update.txt')

  let s:prompt_answers = {
    \   'update': 1,
    \   'skip': 2,
    \   'postpone': 3,
    \ }

  call vimrc#plugins#activate()
endfun

fun! vimrc#plugins#activate() abort
  let l:perform_install = vimrc#plugins#auto_install()
  call vimrc#plugins#runtime_path()
  call plug#begin(g:vimrc#plugins#plugged_path)
  call vimrc#plugins#plugs()
  call plug#end()

  if l:perform_install
    augroup vimrc#plugins#init
      au BufEnter * call vimrc#plugins#auto_install_plugins()
    augroup END
  endif

  augroup vimrc#plugins#init
    au BufEnter * call vimrc#plugins#auto_update()
  augroup END
endfun

fun! vimrc#plugins#runtime_path() abort
  let &runtimepath = join([g:vimrc#plugins#plug_path, &runtimepath], ',')
endfun

fun! vimrc#plugins#is_installed() abort
  return !empty(getftype(s:plug_script_path))
endfun

fun! vimrc#plugins#auto_install() abort
  if vimrc#plugins#is_installed()
    return 0
  endif

  echo 'Installing plug.vim'

  exe join(
    \   [
    \     'silent',
    \     '!curl',
    \     '--create-dirs',
    \     '-sfLo',
    \     shellescape(s:plug_script_path),
    \     'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim',
    \   ],
    \   ' '
    \ )

  return 1
endfun

fun! vimrc#plugins#is_expired() abort
  return vimrc#paths#is_expired(s:plug_timestamp_path, g:vimrc#plugins#plug_update_interval)
endfun

fun! vimrc#plugins#update_timestamp() abort
  call vimrc#paths#write_timestamp(s:plug_timestamp_path)
endfun

fun! vimrc#plugins#auto_install_plugins() abort
  call vimrc#plugins#install()
  call vimrc#plugins#update_timestamp()
endfun

fun! vimrc#plugins#auto_update() abort
  if !vimrc#plugins#is_expired()
    return 0
  endif

  let l:answer = vimrc#plugins#prompt_update()

  if l:answer == s:prompt_answers['update']
    call vimrc#plugins#upgrade()
    call vimrc#plugins#update()
    call vimrc#plugins#update_timestamp()
  elseif l:answer == s:prompt_answers['postpone']
    call vimrc#plugins#update_timestamp()
  endif

  return 1
endfun

fun! vimrc#plugins#prompt_update() abort
  let l:answer = confirm('Update plugins?', "&Yep\n&Nope\n&Postpone")

  if l:answer == 0
    let l:answer = s:prompt_answers['skip']
  endif

  return l:answer
endfun

fun! vimrc#plugins#install() abort
  PlugInstall --sync
  source $MYVIMRC
  quit
endfun

fun! vimrc#plugins#upgrade() abort
  PlugUpgrade
endfun

fun! vimrc#plugins#update() abort
  PlugUpdate --sync
  quit
endfun

fun! vimrc#plugins#plugs() abort
  " Plugs ------------------------------------------------------------------ {{{

  """ ui

  " statusbar
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'

  " colorschemes
  Plug 'gruvbox-community/gruvbox'

  """ syntax/platforms

  Plug 'sheerun/vim-polyglot'
  Plug 'hail2u/vim-css3-syntax'

  """ plugins

  " editor
  Plug 'airblade/vim-gitgutter'
  Plug 'AndrewRadev/linediff.vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'honza/vim-snippets'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'luochen1990/rainbow'
  Plug 'mattn/emmet-vim'
  Plug 'scrooloose/nerdtree'
  Plug 'SirVer/ultisnips'
  Plug 'sjl/gundo.vim'
  Plug 'sjl/splice.vim'
  Plug 'tomtom/tcomment_vim'
  Plug 'tpope/vim-abolish'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'

  " integration with external tools
  Plug 'jamessan/vim-gnupg'
  Plug 'mattn/gist-vim'
  Plug 'mattn/webapi-vim' " gist dependency
  Plug 'tpope/vim-fugitive'
  Plug 'yegappan/grep'

  " frameworks/libs
  Plug 'skwp/vim-rspec'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'

  " linting/formatting/autocomplete
  Plug 'w0rp/ale'

  """ ui (must come last)
  Plug 'ryanoasis/vim-devicons'

  " }}}
endfun
