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
cnoremap s/ s/\v
cnoremap %s/ %s/\v

" Clear highlighted searches
nnoremap <silent><C-N> :nohlsearch<CR>

" Navigate forward and back inside tabs with Shift+Left and Shift+Right
noremap <silent><S-Right> :tabnext<CR>
noremap <silent><S-Left> :tabprevious<CR>

" Exit modes using <Shift-Enter>
" SHIFT-CR => <Esc>, all modes
noremap <S-CR> <Esc>
noremap! <S-CR> <Esc>

" Increment number under cursor
" CTRL-I => CTRL-A
nnoremap <C-I> <C-A>

" Begin/End of line
" CTRL-A => <Home>, all modes
" CTRL-E => <End>, all modes
noremap <C-A> ^
noremap! <C-A> ^
noremap <C-E> $
noremap! <C-E> $

" Navigate through window splits
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

" Maximize window
nnoremap <silent>+ :resize<CR> \| :vertical resize<CR>
