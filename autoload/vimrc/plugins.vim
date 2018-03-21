fun! vimrc#plugins#setup()
  if exists('g:vimrc#plugins#setup_once')
    return
  endif
  let g:vimrc#plugins#setup_once = 1

  call vimrc#paths#setup()

  let g:vimrc#plugins#plugged_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plugged')
  let g:vimrc#plugins#plug_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plug')
  let g:vimrc#plugins#plug_update_interval = 1 * 24 * 3600

  let plug_script_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'autoload', 'plug.vim')
  let plug_timestamp_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'last_update.txt')

  let did_install = vimrc#plugins#plugInstall(plug_script_path)
  let expired = vimrc#paths#expired(plug_timestamp_path, g:vimrc#plugins#plug_update_interval)

  if did_install
    call vimrc#paths#touch(plug_timestamp_path)
    redraw!
  elseif expired
    call vimrc#plugins#plugUpgrade()
    call vimrc#plugins#plugUpdate()
    call vimrc#paths#touch(plug_timestamp_path)
    redraw!
  endif

  let &rtp .= ',' . g:vimrc#plugins#plug_path
  call vimrc#plugins#plugs()
endfun

fun! vimrc#plugins#plugInstall(script_path)
  if !empty(getftype(a:script_path))
    return 0
  endif

  exe "silent !curl --create-dirs -fLo " . shellescape(a:script_path) . " "
    \ "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  autocmd VimEnter * PlugInstall --sync | quit | source $MYVIMRC
  return 1
endfun

fun! vimrc#plugins#plugUpgrade()
  autocmd VimEnter * PlugUpgrade
endfun

fun! vimrc#plugins#plugUpdate()
  autocmd VimEnter * PlugUpdate --sync | quit
endfun

fun! vimrc#plugins#plugs()
  if exists('g:vimrc#plugins#plugs_once')
    return
  endif
  let g:vimrc#plugins#plugs_once = 1

  call plug#begin(g:vimrc#plugins#plugged_path)

  " Plugs ------------------------------------------------------------------ {{{

  """ ui

  Plug 'Dru89/vim-adventurous'
  Plug 'tomasr/molokai'
  Plug 'itchyny/lightline.vim'

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

  " }}}

  call plug#end()
endfun
