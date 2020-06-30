function! vimrc#plugins#setup() abort
  if exists('g:vimrc#plugins#setup_once')
    return
  end
  let g:vimrc#plugins#setup_once = 1

  if vimrc#plugins#should_skip()
    return
  end

  let g:vimrc#plugins#plugged_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plugged')
  let g:vimrc#plugins#plug_path = vimrc#paths#join(g:vimrc#paths#vim_cache, 'plug')
  let g:vimrc#plugins#plug_update_interval = 5 * 24 * 3600 " 5 days

  let s:plug_script_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  let s:plug_script_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'autoload', 'plug.vim')
  let s:plug_timestamp_path = vimrc#paths#join(g:vimrc#plugins#plug_path, 'last_update.txt')

  let s:prompt_answers = {
    \   'update': 1,
    \   'skip': 2,
    \   'postpone': 3,
    \ }

  call vimrc#plugins#activate()
endfunction

function! vimrc#plugins#should_skip() abort
  return exists('g:vscode')
endfunction

function! vimrc#plugins#activate() abort
  call vimrc#plugins#install_plug()

  if !vimrc#plugins#installed()
    echom 'plug.vim could not be installed'
    return
  end

  call vimrc#plugins#runtime_path()
  call plug#begin(g:vimrc#plugins#plugged_path)
  call vimrc#plugins#plugs()
  call plug#end()

  if !vimrc#plugins#plugins_installed()
    augroup vimrc#plugins#init
      au VimEnter * call vimrc#plugins#install_plugins()
    augroup END
  end

  augroup vimrc#plugins#init
    au VimEnter * call vimrc#plugins#update_plug()
  augroup END
endfunction

function! vimrc#plugins#runtime_path() abort
  let &runtimepath = join([g:vimrc#plugins#plug_path, &runtimepath], ',')
endfunction

function! vimrc#plugins#installed() abort
  return vimrc#paths#exists(s:plug_script_path)
endfunction

function! vimrc#plugins#plugins_installed() abort
  return vimrc#paths#exists(g:vimrc#plugins#plugged_path)
endfunction

function! vimrc#plugins#install_plug() abort
  if vimrc#plugins#installed()
    return
  end

  echom 'Installing plug.vim'

  let l:cmd = [
    \ 'curl',
    \ '--create-dirs',
    \ '-sfLo',
    \ shellescape(s:plug_script_path),
    \ shellescape(s:plug_script_url),
    \ ]

  call system(join(l:cmd, ' '))
endfunction

function! vimrc#plugins#is_expired() abort
  return vimrc#paths#is_expired(s:plug_timestamp_path, g:vimrc#plugins#plug_update_interval)
endfunction

function! vimrc#plugins#update_timestamp() abort
  call vimrc#paths#write_timestamp(s:plug_timestamp_path)
endfunction

function! vimrc#plugins#install_plugins() abort
  call vimrc#plugins#install()
  call vimrc#plugins#update_timestamp()
endfunction

function! vimrc#plugins#update_plug() abort
  if !vimrc#plugins#is_expired()
    return 0
  end

  let l:answer = vimrc#plugins#prompt_update()

  if l:answer == s:prompt_answers.update
    call vimrc#plugins#upgrade()
    call vimrc#plugins#update()
    call vimrc#plugins#update_timestamp()
  elseif l:answer == s:prompt_answers.postpone
    call vimrc#plugins#update_timestamp()
  end

  return 1
endfunction

function! vimrc#plugins#prompt_update() abort
  let l:answer = confirm('Update plugins?', "&Yep\n&Nope\n&Postpone")

  if l:answer == 0
    let l:answer = s:prompt_answers.skip
  end

  return l:answer
endfunction

function! vimrc#plugins#install() abort
  PlugInstall --sync
  source $MYVIMRC
  quit
endfunction

function! vimrc#plugins#upgrade() abort
  PlugUpgrade
endfunction

function! vimrc#plugins#update() abort
  PlugUpdate --sync
  quit
endfunction

function! vimrc#plugins#plugs() abort
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
  Plug '13k/vim-keyvalues'

  """ plugins

  " editor
  Plug 'airblade/vim-gitgutter'
  Plug 'AndrewRadev/linediff.vim'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'editorconfig/editorconfig-vim'
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
  Plug 'tpope/vim-rsi'
  Plug 'tpope/vim-sensible'
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
  Plug 'dense-analysis/ale'

  """ ui (must come last)
  Plug 'ryanoasis/vim-devicons'

  " }}}
endfunction
