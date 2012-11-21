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
nnoremap <F3> :NERDTreeToggle<CR>

" Toggle Gundo
nnoremap <F4> :GundoToggle<CR>
