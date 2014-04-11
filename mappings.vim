" Vim. Live it.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" Make Y consistent with C and D
nnoremap Y y$

" Sane regexes
nnoremap / /\v
vnoremap / /\v
cnoremap %s/ %s/\v

" Clear highlighted searches
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" Navigate forward and back inside tabs with Shift+Left and Shift+Right
map <silent><S-Right> :tabnext<CR>
map <silent><S-Left> :tabprevious<CR>

" Map CTRL+] and CTRL+T to CTRL+LeftArrow and CTRL+RightArrow
map <silent><C-Left> <C-T>
map <silent><C-Right> <C-]>

" Exit modes using <Shift-Enter>
" SHIFT-CR => <Esc>, all modes
noremap <S-CR> <Esc>
noremap! <S-CR> <Esc>

" Scroll page N lines down
" CTRL-J => CTRL-E
nnoremap <C-J> <C-E>

" Scroll page N lines up
" CTRL-K => CTRL-Y
nnoremap <C-K> <C-Y>

" Increment number under cursor
" CTRL-I => CTRL-A
nnoremap <C-I> <C-A>

" Begin of line
" CTRL-A => <Home>, all modes
noremap <C-A> <Home>
noremap! <C-A> <Home>

" End of line
" CTRL-E => <End>, all modes
noremap <C-E> <End>
noremap! <C-E> <End>

" Toggle NERDTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Toggle Gundo
nnoremap <leader>u :GundoToggle<CR>

" Resize window splits
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>
