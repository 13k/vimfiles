fun! vimrc#plugins#setup()
  if exists('g:vimrc#plugins#setup_once')
    return
  endif
  let g:vimrc#plugins#setup_once = 1

  call vimrc#paths#setup()

  let g:vimrc#plugins#plugged_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plugged')
  let g:vimrc#plugins#plug_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plug')
  let g:vimrc#plugins#plug_update_interval = 1 * 24 * 3600

  let s:plug_script_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'autoload', 'plug.vim')
  let s:plug_timestamp_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'last_update.txt')

  let s:prompt_answers = {
    \   'update': 1,
    \   'skip': 2,
    \   'postpone': 3,
    \ }

  call vimrc#plugins#activate()
endfun

fun! vimrc#plugins#activate()
  let l:perform_install = vimrc#plugins#autoInstall()
  call vimrc#plugins#runtimePath()
  call plug#begin(g:vimrc#plugins#plugged_path)
  call vimrc#plugins#plugs()
  call plug#end()

  if l:perform_install
    augroup VimrcPluginsInit
      au BufEnter * call vimrc#plugins#autoInstallPlugins()
    augroup END
  endif

  augroup VimrcPluginsInit
    au BufEnter * call vimrc#plugins#autoUpdate()
  augroup END
endfun

fun! vimrc#plugins#runtimePath()
  let &runtimepath = join([g:vimrc#plugins#plug_path, &runtimepath], ',')
endfun

fun! vimrc#plugins#isInstalled()
  return !empty(getftype(s:plug_script_path))
endfun

fun! vimrc#plugins#autoInstall()
  if vimrc#plugins#isInstalled()
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

fun! vimrc#plugins#isExpired()
  return vimrc#paths#isExpired(s:plug_timestamp_path, g:vimrc#plugins#plug_update_interval)
endfun

fun! vimrc#plugins#updateTimestamp()
  call vimrc#paths#writeTimestamp(s:plug_timestamp_path)
endfun

fun! vimrc#plugins#autoInstallPlugins()
  call vimrc#plugins#install()
  call vimrc#plugins#updateTimestamp()
endfun

fun! vimrc#plugins#autoUpdate()
  if !vimrc#plugins#isExpired()
    return 0
  endif

  let l:answer = vimrc#plugins#promptUpdate()

  if l:answer == s:prompt_answers['update']
    call vimrc#plugins#upgrade()
    call vimrc#plugins#update()
    call vimrc#plugins#updateTimestamp()
  elseif l:answer == s:prompt_answers['postpone']
    call vimrc#plugins#updateTimestamp()
  endif

  return 1
endfun

fun! vimrc#plugins#promptUpdate()
  let l:answer = confirm('Update plugins?', "&Yep\n&Nope\n&Postpone")

  if l:answer == 0
    let l:answer = s:prompt_answers['skip']
  endif

  return l:answer
endfun

fun! vimrc#plugins#install()
  PlugInstall --sync
  source $MYVIMRC
  quit
endfun

fun! vimrc#plugins#upgrade()
  PlugUpgrade
endfun

fun! vimrc#plugins#update()
  PlugUpdate --sync
  quit
endfun

fun! vimrc#plugins#plugs()
  " Plugs ------------------------------------------------------------------ {{{

  """ ui

  Plug 'Dru89/vim-adventurous'
  Plug 'tomasr/molokai'
  Plug 'itchyny/lightline.vim'
  Plug 'maximbaz/lightline-ale'

  """ syntax/platforms

  Plug 'briancollins/vim-jst'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'cespare/vim-toml'
  Plug 'chrisbra/csv.vim'
  Plug 'digitaltoad/vim-jade'
  Plug 'elzr/vim-json'
  Plug 'fatih/vim-go'
  Plug 'fatih/vim-nginx'
  Plug 'groenewege/vim-less'
  Plug 'hail2u/vim-css3-syntax'
  Plug 'jeroenbourgois/vim-actionscript'
  Plug 'juvenn/mustache.vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'leafgarland/typescript-vim'
  Plug 'lifepillar/pgsql.vim'
  Plug 'mitsuhiko/vim-jinja'
  Plug 'nono/vim-handlebars'
  Plug 'pangloss/vim-javascript'
  Plug 'rosstimson/scala-vim-support'
  Plug 'slim-template/vim-slim'
  Plug 'tpope/vim-git'
  Plug 'tpope/vim-markdown'
  Plug 'vim-ruby/vim-ruby'
  Plug 'vim-scripts/applescript.vim'
  Plug 'wavded/vim-stylus'

  """ plugins

  " editor
  Plug 'airblade/vim-gitgutter'
  Plug 'AndrewRadev/linediff.vim'
  Plug 'andrewradev/splitjoin.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'honza/vim-snippets'
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim'
  Plug 'mattn/emmet-vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'scrooloose/nerdtree'
  Plug 'SirVer/ultisnips'
  Plug 'sjl/gundo.vim'
  Plug 'sjl/splice.vim'
  Plug 'tpope/vim-dispatch'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-ragtag'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'

  " external tools
  Plug '13k/vim-clang-format'
  Plug 'jamessan/vim-gnupg'
  Plug 'mattn/gist-vim'
  Plug 'mattn/webapi-vim' " gist dependency
  Plug 'mileszs/ack.vim'
  Plug 'mindriot101/vim-yapf'
  Plug 'tpope/vim-fugitive'

  " frameworks/libs
  Plug 'skwp/vim-rspec'
  Plug 'tpope/vim-bundler'
  Plug 'tpope/vim-rails'

  " language server protocol
  Plug 'autozimu/LanguageClient-neovim', {
    \   'branch': 'next',
    \   'do': 'bash install.sh',
    \ }

  " linting
  Plug 'w0rp/ale'

  " autocomplete
  Plug 'roxma/nvim-yarp' " deoplete dependency
  Plug 'roxma/vim-hug-neovim-rpc' " deoplete dependency
  Plug 'Shougo/deoplete.nvim'
  Plug 'zchee/deoplete-go', { 'do': 'make' }

  """ ui (must come last)
  Plug 'ryanoasis/vim-devicons'

  " }}}
endfun

fun! vimrc#plugins#editorconfig()
  augroup EditorConfigInit
    au BufEnter * call vimrc#plugins#editorconfigCheck()
  augroup END
endfun

fun! vimrc#plugins#editorconfigCheck()
  let l:core_bin = get(g:, 'EditorConfig_exec_path')

  if l:core_bin == 0 || empty(l:core_bin)
    let l:core_bin = 'editorconfig'
  endif

  if !executable(l:core_bin)
    call confirm('EditorConfig core is not installed, formatting will NOT happen')
  endif
endfun
